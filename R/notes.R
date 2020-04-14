#' Read Chapter Notes
#' 
#' A window will display with the notes for the selected chapter.
#' 
#' @param chapter The number of the chapter to read. Currently an integer between 1 and 11.
#'
#' @export
notes <- function(chapter) {
  if (missing(chapter)) {
    stop("chapter number is required")
  } else {
    this_chapter <- paste0("chapter_",
                           ifelse(chapter < 10, "0", ""),
                           as.character(chapter))
    if (!this_chapter %in%
        dir(system.file("tutorials", package = "UCLAstats20"))) {
      stop("No notes found for Chapter ", chapter, "\nPlease consider one of these,\n", format(tutorials)) 
    }
    suppressMessages(suppressWarnings(run_tut(this_chapter,
                     package = "UCLAstats20",
                     shiny_args = list(
                       "launch.browser" = .rs.invokeShinyWindowViewer,
                       quiet = TRUE),
                     render_args = list(
                       quiet = TRUE)
                     )))
  }
}