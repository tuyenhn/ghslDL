#' GHSL downloader, helps download raster with specified dataset, product and
#' spatial point
#'
#' @param dataset String - dataset name
#' @param point An `sf` point
#' @param cache Logical - default is `TRUE`, enables HTTP request caching with
#' `httpcache`. If `FALSE`, uncached request.
#' @param load Logical - default is `FALSE`, if `TRUE` a `stars` raster is
#' loaded after download and returned
#' @param overwrite Logical - default is `FALSE`, if `TRUE` allows the
#' downloader to overwrite existing downloaded files
#'
#' @return Nothing. If `load=TRUE`, raster `stars` object
#' @export
#'
#' @examples
#' \dontrun{
#' ghsl_dl("GHS-BUILT-S", sf::st_sfc(sf::st_point(c(106.6297, 10.8231)), crs=4326))
#' }
ghsl_dl <- function(dataset, point, load = FALSE, overwrite = FALSE, cache = TRUE) {
    if (!(dataset %in% datasets$names)) {
        stop("`dataset` must be in `list_datasets()`", call. = FALSE)
    }
    if (class(point)[1] != "sfc_POINT") {
        stop("`point` must be of class `sfc_POINT`", call. = FALSE)
    }
    if (!is.logical(load)) {
        stop("`load` must be of class `logical`", call. = FALSE)
    }
    if (!is.logical(overwrite)) {
        stop("`overwrite` must be of class `logical`", call. = FALSE)
    }
    if (!is.logical(cache)) {
        stop("`cache` must be of class `logical`", call. = FALSE)
    }

    ghsl_dl_(
        dataset = dataset,
        point = point,
        load = load,
        overwrite = overwrite,
        cache = cache
    )
}

ghsl_dl_ <- function(dataset, point, load, overwrite, cache) {
    product_df <- ghslDL::list_products(dataset, cache)
    cat(sprintf("Available products for %s:\n", dataset))
    print(product_df, row.names = FALSE)

    chosen_id <- readline(
        prompt = "Product ID to download (0 or Ctrl+C to cancel): "
    ) %>% as.integer()
    if (chosen_id == 0) {
        stop("Downloader stopped", call. = FALSE)
    }

    product <- product_df[chosen_id, "raw"]

    rowcol <- get_row_col_(point)
    product_url <- get_product_url(
        dataset,
        product,
        rowcol["row"],
        rowcol["col"]
    )

    fname <- utils::tail(stringr::str_split_1(product_url, "/"), 1)
    fpath <- paste(getwd(), fname, sep = "/")
    httr::GET(
        product_url,
        httr::write_disk(fpath, overwrite = overwrite),
        httr::progress()
    )
    cat(sprintf("Download completed\nFile located at: %s\n", fpath))

    if (load) {
        dir <- stringr::str_split_1(fname, "\\.")[1]
        cat(sprintf("Extracting to %s\n", dir))
        utils::unzip(fname, exdir = dir)
        r <- stars::read_stars(
            paste(
                getwd(), dir, paste(dir, "tif", sep = "."),
                sep = "/"
            )
        )
        return(r)
    }
}

#' Helper function, convert inputted sfc_POINT to GHSL's tile row and column
#' NB: Not intended for users
#'
#' @param point An `sfc_POINT` object
#'
#' @return A row and column vector
#' @export
get_row_col_ <- function(point) {
    mollweide <- sf::st_transform(point, sf::st_crs("ESRI:54009")) %>%
        sf::st_coordinates()
    col <- (mollweide[, "X"] + 18041000) %/% 1000000 + 1
    row <- abs((mollweide[, "Y"] - 9000000) %/% 1000000)

    c(col = col, row = row)
}
