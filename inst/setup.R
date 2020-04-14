library(learnr)

put <- function () {
  obj_name <- "tools:UCLAstats20"
  if (!obj_name %in% search()) {
    env <- new.env(parent = emptyenv())
    env$clean_input <- function(x) {
      x <- gsub("\r\n", "\n", x)
      x <- gsub("\\s*#.*?(\n|$)", "\n", x)
      x <- gsub("\n+", "\n", x)
      gsub("\n$|^\n", "", x)
    }
    
    env$checker <- function(
      label,
      user_code,
      solution_code,
      check_code,
      envir_result,
      evaluate_result,
      envir_prep,
      ...
    ) {
      tryCatch({
        user_code <- clean_input(user_code)
        solution_code <- clean_input(solution_code)
        uc <- styler::style_text(user_code)
        user_code <- paste(uc[uc != ""], collapse = "\n")
        solution_code <- paste(styler::style_text(solution_code), collapse = "\n")
        
        if (user_code == solution_code) {
          list(message = learnr::random_praise(),
               correct = TRUE, location = "append")
        } else {
          list(message = learnr::random_encouragement(),
               correct = FALSE, location = "append")
        }
      }, error = function(e) {
        print(e)
      }
      )
    }
    do.call("attach", list(env, name = obj_name))
  }
}

put()
rm("put")

knitr::opts_chunk$set(echo = TRUE,
                      tidy.opts = list(width.cutoff = 60),
                      tidy = "styler",
                      warning = TRUE,
                      comment = "")
options(width = 80)
tutorial_options(exercise.completion = TRUE,
                 exercise.checker = checker)
