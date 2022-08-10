#' Plot Forest Plot from the Data.Frame Object from get_all_stats Function
#'
#' This function plots forest plot from the Data.Frame object from get_all_stats function
#'
#' @param stats The data.frame object output from get_all_stats function. The data.frame can be further modified by the user.
#' @return NULL
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
#' ) %>% plot_forestplot()
#' @export
plot_forestplot = function(stats){
  stats[[" "]] = paste(rep(" ", 50), collapse = "")
  names(stats)[c(2, 5, 10, 6, 9)] = c("Dataset", "P-Value", " ", "95% CI", "N")
  plt = forest(stats[,c(2, 5, 10, 6, 9)],
               est = stats$effect,
               lower = stats$c95_lower,
               upper = stats$c95_upper,
               sizes = stats$se,
               ci_column = 3,
               ref_line = 0,
               footnote = stats$marker[1]
  )
  ggsave(filename = paste0(gsub(":","_",stats$marker[1]),"_forestplot.png"), device = "png", plot = plt,
         dpi = 1200, height = dim(stats)[1], width = 6)
}
