% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check-all.R
\name{check_all}
\alias{check_all}
\title{Run all validation checks}
\usage{
check_all(data, annotations, syn)
}
\arguments{
\item{data}{A tibble or dataframe with the columns:
name, metadataType, species, assay, file_data.
The file_data column should be a list column containing
a dataframe with the file data or \code{NULL} if the data
does not exist. \code{data} is expected to have four rows,
one for each metadataType: individual, biospecimen,
assay, manifest. If file_data is \code{NULL} for a given
metadataType, the metadataType should still be
present.}

\item{annotations}{A data frame of annotation definitions. Must contain at
least three columns: \code{key}, \code{value}, and \code{columnType}.}

\item{syn}{Synapse client object}
}
\value{
List of conditions
}
\description{
Runs all validation checks. Requires an environment configuration
(config) to be set. The config is expected to have templates for
each metadataType, where individual and biospecimen depend on species and
assay depends on the assay type. Additionally, there should be
complete_columns for each metadataType.
}
\examples{
\dontrun{
syn <- synapse$Synapse()
syn$login()

annots <- get_synapse_annotations(syn = syn)

data <- tibble::tibble(
  metadataType = c(
    "manifest",
    "individual",
    "biospecimen",
    "assay"
  ),
  name = c("a", NA, NA, "c"),
  species = "human",
  assay = "rnaSeq",
  file_data = c(
    list(data.frame(a = c(TRUE, FALSE), b = c(1, 3))),
    list(NULL),
    list(NULL),
    list(data.frame(a = c(TRUE, FALSE), b = c(1, 3)))
  )
)
res <- check_all(data, annots, syn)
}
}
