#' Get GWAS Summary Statistics of a Single Variant
#'
#' This function retrieves GWAS summary statistics of a single variant
#'
#' @param filename The directory of the GWAS summary statistics file
#' @param dataset The name that the user wishes to give to the study
#' @return d, a data frame of the summary statistics of the single variant specified
#' @export
get_marker_stats = function(filename, dataset,
                            snp_name,
                            identifier_column_name,
                            effectsize_column_name,
                            stderr_column_name,
                            pvalue_column_name,
                            samplesize_column_name,
                            check_inverse_ref){

  used_inverse = FALSE
  filename = unlist(filename)
  dataset = unlist(dataset)
  cat(paste0("Looking for ", snp_name, " in ", filename, "...\n"))
  d = fread(filename)
  d = as_tibble(d)
  d_snp = d[d[,names(d)==identifier_column_name]==snp_name,]

  if(check_inverse_ref){
    if(length(unlist(strsplit(snp_name, split = ":")))!=4){
      return("SNP name not in chr:pos:ref:alt format...\n")
    }
    snp_name_inv = unlist(strsplit(snp_name, split = ":"))[c(1, 2, 4, 3)] %>%
      paste(collapse = ":")
    if(dim(d_snp)[1]==0){
      d_snp = d[d[,names(d)==identifier_column_name]==snp_name_inv,]
      used_inverse = TRUE
    }
  }

  if(dim(d_snp)[1]==0){
    cat(paste0("No Markers found in ", dataset, "...\n"))
    return(NULL)
  }

  d_snp = d_snp %>%
    select(all_of(identifier_column_name),
           all_of(effectsize_column_name),
           all_of(stderr_column_name),
           all_of(pvalue_column_name),
           all_of(samplesize_column_name))
  names(d_snp) = c("marker", "effect", "se", "pvalue", "n")

  if(used_inverse){
    cat(paste0(snp_name, " may have inversed ref and alt...\n"))
    d_snp[["effect"]] = -d_snp[["effect"]]
  }

  d_snp = d_snp[1,]
  d_snp = d_snp %>%
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

  return(d_snp)
}
