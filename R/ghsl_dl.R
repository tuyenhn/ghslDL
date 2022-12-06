#' GHSL downloader, helps download raster with specified dataset, product and
#' spatial point
#'
#' @param dataset String - dataset name
#' @param point An `sf` point
#'
#' @return The download server response after downloaded
#' @export
#'
#' @examples
#' \dontrun{
#' ghsl_dl("GHS-BUILT-S", sf::st_sfc(sf::st_point(c(106.6297, 10.8231)), crs=4326))
#' }
ghsl_dl <- function(dataset, point) {
    if (!(dataset %in% datasets$names)) {
        stop("`dataset` must be in `list_datasets()`", call. = FALSE)
    }
    if (class(point)[1] != "sfc_POINT") {
        stop("`point` must be of class `sfc_POINT`", call. = FALSE)
    }

    ghsl_dl_(dataset = dataset, point = point)
}

ghsl_dl_ <- function(dataset, point) {
    product_df <- ghslDL::list_products(dataset)
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
        httr::write_disk(fpath),
        httr::progress()
    )
    cat(sprintf("Download completed\nFile located at: %s", fpath))
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