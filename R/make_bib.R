#' Make Default Bibliography File
#'
#' Call this function to create a default bibliography template file.
#'
#' @export
make_bib <- function() {
  pkg_path <- system.file(package = "UCLAstats20")
  resources_path <- file.path(pkg_path, "resources")
  bib_file <- file.path(resources_path, "citations.bib")
  invisible(file.copy(bib_file, file.path(basename(bib_file))))
}