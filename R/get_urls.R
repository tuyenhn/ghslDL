#' Get the base URL of GHSL's download server
#'
#' @returns GHSL's download server base URL
#' @export
get_base_url_ <- function() {
    "http://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL"
}

#' Get the download server URL of the chosen dataset
#' NB: Dataset must be in `list_datasets()`
#'
#' @param dataset String - GHSL dataset name
#'
#' @returns String - GHSL download server URL of chosen dataset
#' @export
#'
#' @examples
#' get_dataset_url("GHS-BUILT-S")
get_dataset_url <- function(dataset) {
    if (!(dataset %in% datasets$names)) {
        stop("dataset must be in `list_datasets()`", call. = FALSE)
    }

    get_dataset_url_(dataset = dataset)
}

get_dataset_url_ <- function(dataset) {
    base_url <- get_base_url_()
    dataset_url <-
        datasets[datasets$names == dataset, ]$folder_url

    full_url <- paste(base_url, dataset_url, sep = "/")
    # print(full_url)
    full_url
}

#' Get the download server URL of the chosen dataset, product and tile
#'
#' @param dataset String - GHSL dataset name
#' @param product String - product name within chosen dataset
#' @param row Numeric - tile row number
#' @param col Numeric - tile column number
#'
#' @returns String - GHSL download server URL of chosen dataset, product and tile
#' @export
#'
#' @examples
#' get_product_url("GHS-BUILT-S", "GHS_BUILT_S_E2018_GLOBE_R2022A_54009_10", 1, 1)
get_product_url <- function(dataset, product, row, col) {
    get_product_url_(dataset, product, row, col)
}

get_product_url_ <- function(dataset, product, row, col) {
    dataset_url <- get_dataset_url(dataset)
    fname <- sprintf("%s_V1_0_R%d_C%d.zip", product, row, col)
    full_p_url <- paste(dataset_url, product, "V1-0", "tiles", fname, sep = "/")
    full_p_url
}
