# UCLAstats20
This is an R package for use in Stats 20 at UCLA.
It has two main functions:
1. It provides two templates for homework.
2. It contains interactive versions of the course notes written by Dr Michael Tsiang.

## Installation

`**NOTE:** Windows users will need to install `R tools` from: https://cran.r-project.org/bin/windows/Rtools/ before installing the devtools` package.

<!--Either run the commands:-->
```
install.packages("devtools")
library(devtools)
install_github("elmstedt/UCLAstats20")
```
<!--Or download the file: `UCLAstats20_1.0.tar.gz` and run the command:
```
install.packages("<PATH TO FILE>/UCLAstats20_1.0.tar.gz", repos = NULL, type = "source")
```
replacing `<PATH TO FILE>` with the location where you saved the file.-->

## Use
You must first load the package with `library("UCLAstats20")`

### Homework Templates

`File` > `New File` > `R Markdown` > `From Template` > `Basic Homework Template`
Name your file something meaningful e.g. `123456789_stats20_hw1` where `123456789` is replaced with your University ID.

This will create a new directory named `123456789_stats20_hw1` containing the required files. You should then, immediately, do:
`File` > `New Project` > `Existing Directory` and select the newly created directory, e.g. `123456789_stats20_hw1`.

### Course Notes

After loading the library, type `notes(#)` where the `#` is replaced with the number corresponding to the chapter number you want to see. Current chapters are 1-11.

This will launch a local shiny app with the course notes and interactive R code environments.

## Copyright Notice

The contents of the course notes are the copyright of Dr Michael Tsiang.
