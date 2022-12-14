% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_marker_stats.R
\name{get_marker_stats}
\alias{get_marker_stats}
\title{Get GWAS Summary Statistics of a Single Variant}
\usage{
get_marker_stats(
  filename,
  dataset,
  snp_name,
  identifier_column_name,
  effectsize_column_name,
  stderr_column_name,
  pvalue_column_name,
  samplesize_column_name,
  check_inverse_ref
)
}
\arguments{
\item{filename}{The directory of the GWAS summary statistics file}

\item{dataset}{The name that the user wishes to give to the study}
}
\value{
d, a data frame of the summary statistics of the single variant specified
}
\description{
This function retrieves GWAS summary statistics of a single variant
}
