
#### 1. Libraries ####

install.packages("pacman")

pacman::p_load(
  terra,
  elevatr,
  sf,
  geodata,
  rayshader,
  magick
)

#### 2. Country Borders ####

path <- getwd()

country_sf <- geodata::gadm(
  country = "VEN",
  level = 0,
  path = path
) |>
sf::st_as_sf()

#### 3. Download Rivers ####

url <- "https://data.hydrosheds.org/file/HydroRIVERS/HydroRIVERS_v10_sa_shp.zip"
destfile <- basename(url)

download.file(
  url = url,
  destfile = destfile,
  mode = "wb"
)

unzip(destfile)

#### 4. Load rivers #####

filename <- list.files(
  path = "HydroRIVERS_v10_sa_shp",
  pattern = ".shp",
  full.names = TRUE
)

country_bbox <- sf::st_bbox(country_sf)

#      xmin      ymin      xmax      ymax 
# -73.35214   0.64876 -59.80701  15.67292 

bbox_wkt <- "POLYGON((
    -73.35214 0.64876,
    -73.35214 15.67292,
    -59.80701 15.67292,
    -59.80701 0.64876,
    -73.35214 0.64876
))"

country_rivers <- sf::st_read(
  filename,
  wkt_filter = bbox_wkt
) |>
sf::st_intersection(
  country_sf
)

plot(sf::st_geometry(country_rivers))

#### 5. River width ####

sort(
  unique(
    country_rivers$ORD_FLOW
  )
)

crs_country <- "+proj=longlat +ellps=intl +towgs84=-270.933,115.599,-360.226,-5.266,-1.238,2.381,-5.109 +no_defs +type=crs"

country_river_width <- country_rivers |>
  dplyr::mutate(
    width = as.numeric(
      ORD_FLOW
    ),
    width = dplyr::case_when(
      width == 2 ~ 8,
      width == 3 ~ 6,
      width == 4 ~ 4,
      width == 5 ~ 2,
      width == 6 ~ 1,
      width == 7 ~ 0.5,
      width == 8 ~ 0.25,
      width == 9 ~ 0.125,
      width == 10 ~ 0.0625,
      TRUE ~ 0
    )
  ) |>
  sf::st_as_sf() |>
  sf::st_transform(crs = crs_country)

#### 6. DEM ####

dem <- elevatr::get_elev_raster(
  locations = country_sf,
  z = 6, clip = "locations"
)

dem_country <- dem |>
  terra::rast() |>
  terra::project(crs_country)

dem_matrix <- rayshader::raster_to_matrix(
  dem_country
)

#### 7. Render scene ####

dem_matrix |>
  rayshader::height_shade(
    texture = colorRampPalette(
      c(
        "#fcc69f",
        "#c67847"
      )
    )(128)
  ) |>
  rayshader::add_overlay(
    rayshader::generate_line_overlay(
      geometry = country_river_width,
      extent = dem_country,
      heightmap = dem_matrix,
      color = "#387B9C",
      linewidth = country_river_width$width,
      data_column_width = "width"
    ), alphalayer = 1
  ) |>
  rayshader::plot_3d(
    dem_matrix,
    zscale = 20,
    solid = FALSE,
    shadow= TRUE,
    shadow_darkness = 1,
    background = "white",
    windowsize = c(600,600),
    zoom = .5,
    phi = 89,
    theta = 0
  )

rayshader::render_camera(
  zoom = .70
)

#### 8. Render Object ####

u <- "https://dl.polyhaven.org/file/ph-assets/HDRIs/hdr/4k/photo_studio_loft_hall_4k.hdr"

hdri_file <- basename(u)

download.file(
  url = u,
  destfile = hdri_file,
  mode = "wb"
)

file_name <- "venezuela-3d-elevation-rivers.png"

rayshader::render_highquality(
  filename = file_name,
  preview = TRUE,
  light = FALSE,
  environment_light =  hdri_file,
  intensity_env = 1.5,
  interactive = FALSE,
  width = 2000,
  height = 2000
)

#### URLs ####

# https://epsg.io/
# https://dl.polyhaven.org/file/ph-assets/HDRIs/hdr/4k/photo_studio_loft_hall_4k.hdr
# https://www.hydrosheds.org/products/hydrorivers