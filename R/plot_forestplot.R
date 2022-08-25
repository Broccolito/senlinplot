#' Plot Forest Plot from the Data.Frame Object from get_all_stats Function
#'
#' This function plots forest plot from the Data.Frame object from get_all_stats function
#'
#' @param stats The data.frame object output from get_all_stats function. The data.frame can be further modified by the user.
#' @param device The format in which the forest plots are saved. png or pdf recommended
#' @param plt_width The width of the plot generated in inches
#' @param plt_height The height of the plot generated in inches
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
plot_forestplot = function(stats, device = "png", plt_width = 15, plt_height = 15){
  if(dim(stats)[1]<=1){
    return("Not enough data was provided...\n")
  }
  stats[[" "]] = paste(rep(" ", 50), collapse = "")
  names(stats)[c(2, 6, 10, 5, 9)] = c("Dataset", "Beta (95% CI)", " ", "P-Value", "N")
  plt = forest(
    stats[,c(2, 6, 10, 5, 9)],
    est = stats$effect,
    lower = stats$c95_lower,
    upper = stats$c95_upper,
    sizes = stats$se,
    ci_column = 3,
    ref_line = 0,
    footnote = paste0(" ", stats$marker[1])
  )
  ggsave(filename = paste0(gsub(":","_",stats$marker[1]),"_forestplot.", device), device = device, plot = plt,
         dpi = 1200, bg = "white", width = plt_width, height = plt_height)
  dev.off()
}
