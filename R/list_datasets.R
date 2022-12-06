#' List available and supported datasets for download from GHSL
#'
#' @return Dataframe - supported datasets with names and descriptions
#' @export
#'
#' @examples
#' list_datasets()
list_datasets <- function() {
    print(
        datasets[, c("names", "description")]
    )
}
