# UCLAstats20
This is an R package for use in Stats 20 at UCLA. The contentS were last updated in 2020 Fall.

This package contains interactive versions of the course notes written by Dr. Michael Tsiang.

## Installation

**NOTE:** Windows users will need to install `R tools` from: https://cran.r-project.org/bin/windows/Rtools/ before installing the `devtools` package.

Run the following code in your R console:
```
install.packages("devtools")
library(devtools)
install_github("ehonig/UCLAstats20")
```

Note that you only need to perform this installation step once.

<!--Or download the file: `UCLAstats20_1.0.tar.gz` and run the command:
```
install.packages("<PATH TO FILE>/UCLAstats20_1.0.tar.gz", repos = NULL, type = "source")
```
replacing `<PATH TO FILE>` with the location where you saved the file.-->

<!-- ## Use
Before you can access the templates, you may need to "restart"  R. You can do this from the top menu bar with **Session > Retart R**, or with the keyboard shortcuts **Ctrl+Shift+F10** (PC/Linux) or **Cmd+Shift+F10** (OSX). **NOTE:** If you are on a laptop or using a keyboard without a dedicated row of function keys above the number keys (typically you may have combined function and media keys, volume up, down, mute, etc.) you'll often have a **`fn`** key located somewhere (often in the lower left corner of the keyboard). You'll need to press this key in conjunction with the above key combination.

### Homework Templates

#### Current v1.1.1+
The best practice is to create a homework _project_ template. You can access this via the menu with,

**File > New Project > New Directory > UCLA Stats 20 Homework**

This will open a dialog box with the following parameters:
* Directory name: This should be something like hw1 or Homework 13. Whatever the last number is in the textbox will be identified as the homework number.
* Subdirectory path, this should be self explanatory. I recommend making a stats20 directory in the home directory of their system (~ on Mac and Linux, Documents on PC) and placing all of their homeworks there.
* Template type: Either basic or advanced. This will append  {.tabset .tabset-fade .tabset-pills} to all Question level headings causing the question parts to appear as tabs.
* Include Bibliography: Should a bibliography file be included (and generated if none is provided).
* Include Boilerplate: Should some boilerplate code be generated or not?
* Include question prompts: Should the homework question prompts be included in the homework template?
* Name: This should be your full name.
* UID: This should be your university ID.
* Bibliography file: You may select a custom bibliography file from your system. This will copy the file selected into your project directory and update the YAML header accordingly.
* Save as defaults: This will save your name, uid and bibliography file as defaults so you don't need to re-enter them each time.

When the project is created the following occurs:
* The working directory is updated to your project directory.
* A file of the form: 123456789_stats20_hwX.Rmd is generated.
* If you are including a bibliography, a .bib file will be created in the working directory.
* data and images directories are created.
* If you are doing a homework for which there is an existing skeleton,
    * Your boilerplate will come from that specific homework .Rmd file.
    * Otherwise a generic boilerplate will be created.
* If there are files in data or images they will be downloading into the respective subdirectories in you working directory.
* If there are any issues in generating the homework project a file will be created in their working directory named: **`PLEASE READ - Project Creation Notes`**. Things which will cause this file to be created include:
    * Making a HW project for which there does not exist an online template.
    * Making a project which would cause the template .Rmd file to be overwritten (a new file with an appended index number is created instead).
    * Trying to use a .bib file which cannot be found on their computer.

#### Deprecated
Individual template files can be created by:

`File` > `New File` > `R Markdown` > `From Template` > `Basic Homework Template`
Name your file something meaningful e.g. `123456789_stats20_hw1` where `123456789` is replaced with your University ID.

This will create a new directory named `123456789_stats20_hw1` containing the required files. You should then, immediately, do:
`File` > `New Project` > `Existing Directory` and select the newly created directory, e.g. `123456789_stats20_hw1`. -->

## Accessing Interactive Course Notes

In the R console, first load the package by using the command `library(UCLAstats20)`. Then, run the command `notes(#)` where the `#` is replaced with the number corresponding to the chapter number you want to see. Current chapters are 1-11.

This will launch a local shiny app with the course notes and interactive R code environments.

For example:
```
library(UCLAstats20)
notes(1)
```

Note that you only need to load the package once per R session to access the `notes()` function. This means that every new session you will need to re-load the package, but also that you only need to load it once per session.

## Copyright Notice

The contents of the course notes are the copyright of Dr Michael Tsiang.

## Contributor Credits

To my knowledge, this package was originally created by Jake Elmstedt and Michael Tsiang with help from Ethan Allavarpu.
