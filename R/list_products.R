#' List available products within chosen dataset
#'
#' @param dataset String - GHSL dataset name
#' @param cache Logical - default is `TRUE`, enables HTTP request caching with
#' `httpcache`. If `FALSE`, uncached request.
#'
#' @return Dataframe - products available for download within chosen dataset
#' @export
#'
#' @examples
#' list_products("GHS-BUILT-V")
list_products <- function(dataset, cache = TRUE) {
    if (!(dataset %in% datasets$names)) {
        stop("dataset must be in `list_datasets()`", call. = FALSE)
    }
    if (!is.logical(cache)) {
        stop("`cache` must be of class `logical`", call. = FALSE)
    }

    list_products_(dataset = dataset, cache = cache)
}

list_products_ <- function(dataset, cache) {
    dataset_url <- get_dataset_url(dataset)
    if (!cache) {
        httpcache::dropOnly(dataset_url)
    }
    raw_html <- httpcache::GET(dataset_url)
    html_res <- xml2::read_html(raw_html)
    links <- xml2::xml_find_all(html_res, "//a") %>%
        xml2::xml_text() %>%
        .[grepl("^GHS", .)] %>%
        gsub("/", "", .)

    df <- data.frame(raw = links)
    df$epoch <- sapply(df$raw, FUN = function(x) {
        stringr::str_split_1(x, "_") %>%
            .[grepl("^[A-Z]{1}\\d{4}([A-Z]{3})?$", .)] %>%
            substring(2, 5)
    })
    df$resolution <- sapply(df$raw, FUN = function(x) {
        stringr::str_split_1(x, "_") %>%
            tail(1)
    })
    df %<>% tibble::rownames_to_column("ID")
    df
}
