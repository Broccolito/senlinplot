#' Get GWAS Summary Statistics of a Single Variant
#'
#' This function retrieves GWAS summary statistics of a single variant
#'
#' @param filename The directory of the GWAS summary statistics file
#' @param dataset The name that the user wishes to give to the study
#' @return d, a data frame of the summary statistics of the single variant specified
#' @export
get_marker_stats = function(filename, dataset){
  filename = unlist(filename)
  dataset = unlist(dataset)
  cat(paste0("Looking for ", snp_name, " in ", filename, "...\n"))
  d = fread(filename)
  d = as_tibble(d)
  d = d[d[,names(d)==identifier_column_name]==snp_name,]
  d = d %>%
    select(all_of(identifier_column_name),
           all_of(effectsize_column_name),
           all_of(stderr_column_name),
           all_of(pvalue_column_name),
           all_of(samplesize_column_name))
  names(d) = c("marker", "effect", "se", "pvalue", "n")
  d = d[1,]
  d = d %>%
    mutate(c95_upper = effect + 1.96*se) %>%
    mutate(c95_lower = effect - 1.96*se) %>%
    mutate(dataset = dataset) %>%
    mutate(pvalue = format(pvalue, scientific = TRUE, big.mark = ",", digits = 3)) %>%
    mutate(ci = paste0(
      round(effect, 2),
      " (",
      round(c95_lower, 2),
      ", ",
      round(c95_upper, 2),
      ")"
    )) %>%
    select(marker, dataset, effect, se, pvalue, ci, c95_lower, c95_upper, n)

  return(d)
}
