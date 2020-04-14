#' Custom run_tutorial function from learnr to accept and pass render_args.
#'
#' @param name 
#' @param package 
#' @param shiny_args 
#' @param render_args 
#'
#' @return
run_tut <- function (name = NULL, package = NULL, shiny_args = list(), render_args = NULL) {
  # removed code to install tutorial dependencies
  # (for UCLAstats20 all dependencies should be in Imports)
  tutorial_path <- system.file("tutorials", name, package = package)
  withr::with_dir(tutorial_path, {
    # if (!identical(Sys.getenv("SHINY_PORT", ""), "")) {
      withr::local_envvar(c(RMARKDOWN_RUN_PRERENDER = "0"))
    # }
    rmarkdown::run(file = NULL,
                   dir = tutorial_path,
                   shiny_args = shiny_args,
                   render_args = render_args)
  })
}