
# senlinplot

<img src="logo.svg" alt="Badge" width="150" style="zoom:50%;" />

The goal of senlinplot is to make forest plost from multiple GWAS summary statistics files.

## Installation

You can install the development version of senlinplot like so:

``` r
if(!require("senlinplot")){
  devtools::install_github("Broccolito/senlinplot")
  library(senlinplot)
}
```

## Example

This is a basic example which shows you how to Plot a forest plot for SNP 12:48198234:G:T, given file **CHD_TE_SUMSTAT_META_0110221.txt** and **PVD_TE_META_X_0111221.txt**

``` r
library(senlinplot)

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

![Example file](example.png)

Alternatively, the data.frame used by the plot_forestplot_from_file can be obtained separately and further edited using:

```R
d = get_all_stats(
  snp_name = "12:48198234:G:T",
  filelist = c("CHD_TE_SUMSTAT_META_0110221.txt",
               "PVD_TE_META_X_0111221.txt"),
  dataset_list = c("CHD", "PVD")
)
```

The data.frame generated will look like:

| marker          | dataset |  effect |     se | pvalue   | ci                  | c95_lower | c95_upper |    n |
| :-------------- | :------ | ------: | -----: | :------- | :------------------ | --------: | --------: | ---: |
| 12:48198234:G:T | CHD     |  0.1588 | 0.1020 | 1.19e-01 | 0.16 (-0.04, 0.36)  | -0.041120 |  0.358720 | 8983 |
| 12:48198234:G:T | PVD     | -0.0100 | 0.2712 | 9.71e-01 | -0.01 (-0.54, 0.52) | -0.541552 |  0.521552 | 2433 |

Rows can be added or deleted to customize the look of the forest plot.
