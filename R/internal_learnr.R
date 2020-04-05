#' Copied from learnr
#'
#' @param dir 
#'
#' @return
install_tutorial_dependencies <- function (dir) {
  needed_pkgs <- get_needed_pkgs(dir)
  if (length(needed_pkgs) == 0) {
    return(invisible())
  }
  if (!interactive()) {
    stop("The following packages need to be installed:\n", 
         format_needed_pkgs(needed_pkgs))
  }
  answer <- ask_pkgs_install(needed_pkgs)
  if (answer == 2) {
    stop("The tutorial is missing required packages and cannot be rendered.")
  }
  utils::install.packages(needed_pkgs)
}

#' Copied from learnr
#'
#' @param name 
#' @param package 
#'
#' @return
get_tutorial_path <- function (name, package) {
  tutorial_path <- system.file("tutorials", name, package = package)
  if (!utils::file_test("-d", tutorial_path)) {
    tutorials <- available_tutorials(package)
    possible_tutorials <- tutorials$name
    msg <- paste0("Tutorial \"", name, "\" was not found in the \"", 
                  package, "\" package.")
    adist_vals <- adist(possible_tutorials, name, ignore.case = TRUE)
    if (any(adist_vals <= 3)) {
      best_match <- possible_tutorials[which.min(adist_vals)]
      msg <- paste0(msg, "\n", "Did you mean \"", best_match, 
                    "\"?")
    }
    stop.(msg, "\n", format(tutorials))
  }
  tutorial_path
}

#' Custom run_tutorial function from learnr to accept and pass render_args.
#'
#' @param name 
#' @param package 
#' @param shiny_args 
#' @param render_args 
#'
#' @return
run_tut <- function (name = NULL, package = NULL, shiny_args = NULL, render_args = NULL) {
  if (is.null(package) && !is.null(name)) {
    stop.("`package` must be provided if `name` is provided.")
  }
  tutorials <- available_tutorials(package = package)
  if (is.null(name)) {
    message(format(tutorials))
    return(invisible(tutorials))
  }
  tutorial_path <- get_tutorial_path(name, package)
  learnr:::install_tutorial_dependencies(tutorial_path)
  if (is.null(shiny_args)) 
    shiny_args <- list()
  if (is.null(shiny_args$launch.browser)) {
    shiny_args$launch.browser <- (interactive() || identical(Sys.getenv("LEARNR_INTERACTIVE", 
                                                                        "0"), "1"))
  }
  withr::with_dir(tutorial_path, {
    if (!identical(Sys.getenv("SHINY_PORT", ""), "")) {
      withr::local_envvar(c(RMARKDOWN_RUN_PRERENDER = "0"))
    }
    rmarkdown::run(file = NULL,
                   dir = tutorial_path,
                   shiny_args = shiny_args,
                   render_args = render_args)
  })
}