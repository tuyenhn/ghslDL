% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_urls.R
\name{get_dataset_url}
\alias{get_dataset_url}
\title{Get the download server URL of the chosen dataset
NB: Dataset must be in \code{list_datasets()}}
\usage{
get_dataset_url(dataset)
}
\arguments{
\item{dataset}{String - GHSL dataset name}
}
\value{
String - GHSL download server URL of chosen dataset
}
\description{
Get the download server URL of the chosen dataset
NB: Dataset must be in \code{list_datasets()}
}
\examples{
get_dataset_url("GHS-BUILT-S")
}
