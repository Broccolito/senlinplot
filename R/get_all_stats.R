#' Plot Forest Plot from GWAS Summary Statistics Files
#'
#' This function plots forest plot from GWAS summary statistics files
#'
#' @param snp_name The name of the SNP specified at the identifier column, usually as CHR:POS:REF:ALT
#' @param filelist A list of GWAS summary statistics files to process
#' @param dataset_list A list of names of the studies specified by the user
#' @param identifier_column_name The column name of the unique SNP identifier
#' @param effectsize_column_name The column name of estimated effect size
#' @param stderr_column_name The column name of estimated standard error
#' @param pvalue_column_name The column name of estimated P-value
#' @param samplesize_column_name The column name of study sample size
#' @return stats, a data,frame object that can be piped into plot_forestplot function
#' @examples
#' get_all_stats(
#'   snp_name = "12:48198234:G:T",
#'   filelist = c(
#'     "CHD_TE_SUMSTAT_META_0110221.txt",
#'     "PVD_TE_META_X_0111221.txt"
#'   ),
#'   dataset_list = c(
#'     "CHD",
#'     "PVD"
#'   ),
#'   identifier_column_name = "MarkerName",
#'   effectsize_column_name = "Effect",
#'   stderr_column_name = "StdErr",
#'   pvalue_column_name = "P-value",
#'   samplesize_column_name = "N"
#' )
#' @export
get_all_stats = function(
    snp_name = "12:48198234:G:T",
    filelist = c(
      "study1.txt",
      "study2.txt"
    ),
    dataset_list = c(
      "STUDY1",
      "STUDY2"
    ),
    identifier_column_name = "MarkerName",
    effectsize_column_name = "Effect",
    stderr_column_name = "StdErr",
    pvalue_column_name = "P-value",
    samplesize_column_name = "N"
){
  filelist = tibble(filelist = filelist) %>%
    split(.$filelist)
  dataset_list = tibble(dataset_list = dataset_list) %>%
    split(.$dataset_list)
  stats = map2(filelist, dataset_list, get_marker_stats) %>%
    reduce(rbind.data.frame)
  return(stats)
}

