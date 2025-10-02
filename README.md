# 3D Painting - Elevation & Rivers

Small R project that generates 3D renders of country elevation with river overlays using HydroSHEDS rivers and elevation data.

Quick links
- Scripts: [3Delevation.R](3Delevation.R), [3Delevation_CHE.R](3Delevation_CHE.R)  
- Data & outputs:
  - [.gitignore](.gitignore)
  - [HydroRIVERS_v10_eu_shp.zip](HydroRIVERS_v10_eu_shp.zip)
  - [HydroRIVERS_v10_sa_shp.zip](HydroRIVERS_v10_sa_shp.zip)
  - [photo_studio_loft_hall_4k.hdr](photo_studio_loft_hall_4k.hdr)
  - Outputs: [switzerland-3d-elevation-rivers.png](switzerland-3d-elevation-rivers.png), [venezuela-3d-elevation-rivers.png](venezuela-3d-elevation-rivers.png), [venezuela-3d-elevation-rivers_PRINT.png](venezuela-3d-elevation-rivers_PRINT.png), [venezuela-3d-elevation-rivers.svg](venezuela-3d-elevation-rivers.svg)
  - Cached GADM: [gadm/gadm41_CHE_0_pk.rds](gadm/gadm41_CHE_0_pk.rds), [gadm/gadm41_VEN_0_pk.rds](gadm/gadm41_VEN_0_pk.rds)
  - HydroRIVERS TechDoc: [HydroRIVERS_TechDoc_v10.pdf](HydroRIVERS_TechDoc_v10.pdf)

Overview
- [3Delevation.R](3Delevation.R) produces the Venezuela render. Key symbols: [`country_sf`](3Delevation.R), [`country_rivers`](3Delevation.R), [`country_river_width`](3Delevation.R), [`dem`](3Delevation.R), [`dem_country`](3Delevation.R), [`dem_matrix`](3Delevation.R), [`file_name`](3Delevation.R).
- [3Delevation_CHE.R](3Delevation_CHE.R) produces the Switzerland render. Key symbols: [`country_sf`](3Delevation_CHE.R), [`country_rivers`](3Delevation_CHE.R), [`country_river_width`](3Delevation_CHE.R), [`dem`](3Delevation_CHE.R), [`dem_country`](3Delevation_CHE.R), [`dem_matrix`](3Delevation_CHE.R), [`file_name`](3Delevation_CHE.R).

Requirements
- R (>= 4.x)
- Packages used (scripts call pacman): terra, elevatr, sf, geodata, rayshader, magick  
Install once:
```r
install.packages("pacman")
pacman::p_load(terra, elevatr, sf, geodata, rayshader, magick)
```

How to run
- Interactive (RStudio): open [3Delevation.R](3Delevation.R) or [3Delevation_CHE.R](3Delevation_CHE.R) and run top-to-bottom.
- CLI:
```sh
Rscript 3Delevation.R
Rscript 3Delevation_CHE.R
```

Notes & tips
- The scripts download HydroRIVERS zips and the HDR environment map; those files are included in the repo for convenience but are ignored by [.gitignore](.gitignore) patterns for fresh downloads.
- If `elevatr::get_elev_raster()` fails for large extents, reduce `z` or split the area. See [`dem`](3Delevation.R) and [`dem`](3Delevation_CHE.R).
- River overlay generation uses [`country_river_width`](3Delevation.R) / [`country_river_width`](3Delevation_CHE.R) and `rayshader::generate_line_overlay()` with `linewidth` reading from the `width` column.
- Camera, lighting and high-quality render parameters are set near the end of each script (see `rayshader::plot_3d()` / `rayshader::render_highquality()` calls).

License
- Add a LICENSE file if you want to publish this repository publicly.

```// filepath: README.md

# 3D Painting - Elevation & Rivers

Small R project that generates 3D renders of country elevation with river overlays using HydroSHEDS rivers and elevation data.

Quick links
- Scripts: [3Delevation.R](3Delevation.R), [3Delevation_CHE.R](3Delevation_CHE.R)  
- Data & outputs:
  - [.gitignore](.gitignore)
  - [HydroRIVERS_v10_eu_shp.zip](HydroRIVERS_v10_eu_shp.zip)
  - [HydroRIVERS_v10_sa_shp.zip](HydroRIVERS_v10_sa_shp.zip)
  - [photo_studio_loft_hall_4k.hdr](photo_studio_loft_hall_4k.hdr)
  - Outputs: [switzerland-3d-elevation-rivers.png](switzerland-3d-elevation-rivers.png), [venezuela-3d-elevation-rivers.png](venezuela-3d-elevation-rivers.png), [venezuela-3d-elevation-rivers_PRINT.png](venezuela-3d-elevation-rivers_PRINT.png), [venezuela-3d-elevation-rivers.svg](venezuela-3d-elevation-rivers.svg)
  - Cached GADM: [gadm/gadm41_CHE_0_pk.rds](gadm/gadm41_CHE_0_pk.rds), [gadm/gadm41_VEN_0_pk.rds](gadm/gadm41_VEN_0_pk.rds)
  - HydroRIVERS TechDoc: [HydroRIVERS_TechDoc_v10.pdf](HydroRIVERS_TechDoc_v10.pdf)

Overview
- [3Delevation.R](3Delevation.R) produces the Venezuela render. Key symbols: [`country_sf`](3Delevation.R), [`country_rivers`](3Delevation.R), [`country_river_width`](3Delevation.R), [`dem`](3Delevation.R), [`dem_country`](3Delevation.R), [`dem_matrix`](3Delevation.R), [`file_name`](3Delevation.R).
- [3Delevation_CHE.R](3Delevation_CHE.R) produces the Switzerland render. Key symbols: [`country_sf`](3Delevation_CHE.R), [`country_rivers`](3Delevation_CHE.R), [`country_river_width`](3Delevation_CHE.R), [`dem`](3Delevation_CHE.R), [`dem_country`](3Delevation_CHE.R), [`dem_matrix`](3Delevation_CHE.R), [`file_name`](3Delevation_CHE.R).

Requirements
- R (>= 4.x)
- Packages used (scripts call pacman): terra, elevatr, sf, geodata, rayshader, magick  
Install once:
```r
install.packages("pacman")
pacman::p_load(terra, elevatr, sf, geodata, rayshader, magick)
```

How to run
- Interactive (RStudio): open [3Delevation.R](3Delevation.R) or [3Delevation_CHE.R](3Delevation_CHE.R) and run top-to-bottom.
- CLI:
```sh
Rscript 3Delevation.R
Rscript 3Delevation_CHE.R
```

Notes & tips
- The scripts download HydroRIVERS zips and the HDR environment map; those files are included in the repo for convenience but are ignored by [.gitignore](.gitignore) patterns for fresh downloads.
- If `elevatr::get_elev_raster()` fails for large extents, reduce `z` or split the area. See [`dem`](3Delevation.R) and [`dem`](3Delevation_CHE.R).
- River overlay generation uses [`country_river_width`](3Delevation.R) / [`country_river_width`](3Delevation_CHE.R) and `rayshader::generate_line_overlay()` with `linewidth` reading from the `width` column.
- Camera, lighting and high-quality render parameters are set near the end of each script (see `rayshader::plot_3d()` / `rayshader::render_highquality()` calls).

License
- Add a LICENSE file if you want to publish this repository publicly.
