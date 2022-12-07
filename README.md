# ghslDL: R package to download GHSL datasets
[![R](https://github.com/tuyenhn/ghslDL/actions/workflows/r.yml/badge.svg)](https://github.com/tuyenhn/ghslDL/actions/workflows/r.yml)

An R downloader that allows you to download [GHSL](https://ghsl.jrc.ec.europa.eu/) rasters without leaving the comfort of RStudio. The downloads are 
[tile-based](https://ghsl.jrc.ec.europa.eu/download.php?ds=bu), meaning you won't be downloading the rasters as a whole (global coverage) but only where you need! 
Through this downloader you can have direct access to GHSL's HTTP directory server and explore the available products in different epochs and resolutions, all requests 
are cached to not get rate limited by GHSL. More information about GHSL datasets and its products [here](https://ghsl.jrc.ec.europa.eu/datasets.php) (recommended).

# Installing
The package is in very early development and is not available on CRAN (yet).

The package can currently be installed with
```
remotes::install_github("tuyenhn/ghslDL")
```

# Usage
Load the package with
```
library(ghslDL)
```
Documentation and examples are included with each function, this is the recommended way to understand the package and its functions. But in summary:
- `ghslDL::ghsl_dl(dataset, point)` runs the downloader, list out available products for _dataset_ and automatically convert _point_ into the correct tile to download.
- `ghslDL::list_dataset()` list out available datasets currently being supported by the package (more to come!). You should run this to see what's avaialble before 
running the downloader.
- `ghslDL::list_products(dataset)` list out available products in the chosen dataset. Automatically runs with the downloader.
