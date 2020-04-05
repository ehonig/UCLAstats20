#' Read Chapter Notes
#'
#' @param chapter The number of the chapter to read.
#'
#' @return A window will display with the notes for the selected chapter.
#' @export
notes <- function(chapter) {
  # lifted from learnr:::available_tutorials_for_package()
  tutorials_dir <- system.file("tutorials", package = "UCLAstats20")
  tutorial_folders <- list.dirs(tutorials_dir, full.names = TRUE, 
                                recursive = FALSE)
  names(tutorial_folders) <- basename(tutorial_folders)
  rmd_info <- lapply(tutorial_folders, function(tut_dir) {
    dir_rmd_files <- dir(tut_dir, pattern = "\\.Rmd$", recursive = FALSE, 
                         full.names = TRUE)
    dir_rmd_files_length <- length(dir_rmd_files)
    if (dir_rmd_files_length == 0) {
      return(NULL)
    }
    data.frame(package = "UCLAstats20", name = basename(tut_dir), 
               title = rmarkdown::yaml_front_matter(dir_rmd_files[1])$title %||% 
                 NA, stringsAsFactors = FALSE, row.names = FALSE)
  })
  has_no_rmd <- vapply(rmd_info, is.null, logical(1))
  if (all(has_no_rmd)) {
    return(an_error("No tutorial .Rmd files found for package: \"", 
                    package, "\""))
  }
  rmd_info <- rmd_info[!has_no_rmd]
  tutorials <- do.call(rbind, rmd_info)
  class(tutorials) <- c("learnr_available_tutorials", class(tutorials))
  this_chapter <- paste0("chapter_",
                         ifelse(chapter < 10, "0", ""),
                         as.character(chapter))
  list(tutorials = tutorials, error = NULL)
  # End lift.
  if (!this_chapter %in% tutorials$name) {
    stop("No notes found for Chapter ", chapter, "\nPlease consider one of these,\n", format(tutorials)) 
  }
  suppressWarnings(learnr::run_tutorial(),
                                          package = "UCLAstats20",
                                          shiny_args = list(
                                            "launch.browser" = .rs.invokeShinyWindowViewer,
                                            quiet = TRUE))
}