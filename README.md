
# senlinplot

<!-- badges: start -->
<!-- badges: end -->

The goal of senlinplot is to plot forest plot from multiple GWAS summary statistics files

## Installation

You can install the development version of senlinplot like so:

``` r
if(!require("senlinplot")){
  devtools::install_github("Broccolito/senlinplot")
  library(senlinplot)
}
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(senlinplot)

### Plot a forest plot for SNP 12:48198234:G:T
# Given file CHD_TE_SUMSTAT_META_0110221.txt and PVD_TE_META_X_0111221.txt
plot_forestplot_from_file(
  snp_name = "12:48198234:G:T",
  filelist = c(
    "CHD_TE_SUMSTAT_META_0110221.txt",
    "PVD_TE_META_X_0111221.txt"
  ),
  dataset_list = c(
    "CHD",
    "PVD"
  ),
  identifier_column_name = "MarkerName",
  effectsize_column_name = "Effect",
  stderr_column_name = "StdErr",
  pvalue_column_name = "P-value",
  samplesize_column_name = "N"
)

```

Here is an example figure generated using senlinplot:

![Example file](12_48198234_G_T_forestplot.png)

