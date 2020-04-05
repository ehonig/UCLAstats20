#' Read Chapter Notes
#'
#' @param chapter The number of the chapter to read.
#'
#' @return A window will display with the notes for the selected chapter.
#' @export
notes <- function(chapter) {
  suppressWarnings(learnr::run_tutorial(paste0("chapter_",
                              ifelse(chapter < 10, "0", ""),
                              as.character(chapter)),
                       package = "UCLAstats20",
                       shiny_args = list(
                         "launch.browser" = .rs.invokeShinyWindowViewer,
                         quiet = TRUE)))
}