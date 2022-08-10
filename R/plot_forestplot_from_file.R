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
#' @return NULL
#' @examples
#' plot_forestplot_from_file(
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
plot_forestplot_from_file = function(
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
  stats = get_all_stats(
    snp_name = snp_name,
    filelist = filelist,
    dataset_list = dataset_list,
    identifier_column_name = identifier_column_name,
    effectsize_column_name = effectsize_column_name,
    stderr_column_name = stderr_column_name,
    pvalue_column_name = pvalue_column_name,
    samplesize_column_name = samplesize_column_name
  )
  plot_forestplot(stats)
}