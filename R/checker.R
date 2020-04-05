checker <- function(
  label,
  user_code,
  solution_code,
  check_code,
  envir_result,
  evaluate_result,
  envir_prep,
  ...
) {
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
}