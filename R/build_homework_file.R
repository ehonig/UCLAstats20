build_header <- function(bib_string, hw, ...) {
  dots <- list(...)
  c(
    "---",
    paste0("title: \"Stats 20, 20f -- Homework ", hw,"\""),
    paste("author: \"", dots[["student"]], "--", dots[["uid"]],"\""),
    paste0("date: \"", format(Sys.time(),
                              format = "%A, %B %d, %Y<br/>%X"), "\""),
    "output:",
    "  html_document:",
    "    theme: paper",
    "    code_folding: show",
    "    df_print: paged",
    "    tidy: yes",
    "    toc: yes",
    "    toc_depth: 4",
    "    toc_float: yes",
    bib_string,
    "nocite: '@*'",
    "---",
    "",
    "```{r setup, include=FALSE}",
    "knitr::opts_chunk$set(echo    = TRUE,",
    "                      warning = FALSE,",
    "                      message = FALSE,",
    "                      comment = \"\")",
    "```",
    ""
  )
}

build_homework_file <- function(path, ...) {
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  
  
  hw <- tail(regmatches(path, gregexpr("\\d+", path))[[1]], 1)
  pkg_path <- system.file(package = "UCLAstats20")
  resources_path <- file.path(pkg_path, "resources")
  project_notes <- NULL
  
  dots <- list(...)
  if (dots[["bib"]]) {
    if (dots[["bib_file"]] == "") {
      bib_file <- file.path(resources_path, "citations.bib")
      file.copy(bib_file, file.path(path, basename(bib_file)))
    } else {
      bib_file <- normalizePath(dots[["bib_file"]])
    }
    if (file.exists(bib_file)) {
      file.copy(bib_file, file.path(path, basename(bib_file)))
      bib_string <- paste("bibliography:", basename(bib_file))
    } else {
      project_notes <- c(project_notes, "Bibliography file not found, generating example bibliography file.")
      bib_string <- character(0)
    }
  } else {
    bib_string <- character(0)
  }

  # Make custom YAML header  
  my_yaml <- build_header(bib_string = bib_string, hw, ...)

  # Check if Homework file exists
  base_url <- paste0("https://raw.githubusercontent.com/elmstedt/stats20_homework/master/hw", hw, "/")
  manifest <- try(read.csv(paste0(base_url, "manifest")), silent = TRUE)
  
  
  if (inherits(manifest, "try-error")) {
    hw_body <- if (dots[["boilerplate"]]) {
      project_notes <- c(project_notes, paste0("No homework files found for Homework ", hw, ", building generic boilerplate."))
      readLines(file.path(resources_path,
                          paste0(dots[["type"]], "_", "boilerplate.Rmd")))
    }
  } else {
    if (any(manifest[["dir"]] == "data")) {
      dir.create(file.path(path, "data"),
                 recursive = TRUE,
                 showWarnings = FALSE)  
    }
    if (any(manifest[["dir"]] == "images")) {
      dir.create(file.path(path, "images"),
                 recursive = TRUE,
                 showWarnings = FALSE)  
    }
    body_file <- trimws(manifest[manifest[["dir"]] == "body", "file"])
    body_url <- paste0(base_url, "body/", body_file)
    hw_body <- RCurl::getURL(body_url)
    body_parts <- strsplit(hw_body, "\n")[[1]]
    
    if (dots[["type"]] == "Advanced") {
      h3 <- grep(pattern = "^### ", body_parts)
      tabs <- "{.tabset .tabset-fade .tabset-pills}"
      body_parts[h3] <- paste(body_parts[h3], tabs)
    }
    if (!dots[["prompt"]]) {
      idx <- grepl("^(#|<--|\\(i+\\)|```\\{r|$)", body_parts)
      keep <- gsub("\\).*$", "\\)", body_parts[idx])
      body_parts <- gsub("```\\{r.*", "```\\{r}\n\n```", keep)
    }
    hw_body <- gsub("\n\n+", "\n\n", paste(body_parts, collapse = "\n"))
    
    aux_mani <- manifest[manifest[["dir"]] != "body", ]
    if (nrow(aux_mani)) {
      aux_dir <- trimws(aux_mani[["dir"]])
      aux_file <- trimws(aux_mani[["file"]])
      dl_files <- paste(base_url,
                        paste(aux_dir, aux_file, sep = "/"),
                        sep = "/")
      for (i in seq_along(dl_files)) {
        download.file(dl_files[[i]],
                      file.path(path,
                                aux_dir[[i]],
                                aux_file[[i]]),
                      mode = "wb")
      }
    }
  }
  hw_text <- c(my_yaml, hw_body)
  if (length(bib_string) > 0) {
    hw_text <- c(hw_text, "\n\n\n## Citations\n")
  }
  # write to index file
  hw_name <- paste0(dots[["uid"]], "_stats20_hw", hw, ".Rmd")
  # check if hw already exists,if so append iterator so as not to overwrite
  if (file.exists(file.path(path, hw_name))) {
    project_notes <- c(project_notes, "A file for this homework already exists, look for appended filename.")
    hw_pat <- strsplit(hw_name, "\\.")[[c(1, 1)]]
    files <- dir(path, paste0(hw_pat, "_"))
    iter <- max(as.integer(unlist(regmatches(a <- gsub(".*_", "", files),
                                             gregexpr("\\d+", a)))),
                0) + 1
    hw_name <- paste0(hw_pat, "_", iter, ".Rmd")
  }
  if (dots[["save"]]) {
    dcf_file <- dir(pkg_path,
                    pattern = "\\.dcf",
                    recursive = TRUE,
                    full.names = TRUE)
    dcf <- readLines(dcf_file)
    dcf_updates <- grep("Label: Name|Label: UID|Label: Save as Defaults|Label: Bibliography File", dcf) + 1
    dcf[dcf_updates] <- paste("Default:", c(dots[["student"]], dots[["uid"]], dots[["bib_file"]], "On"))
    writeLines(dcf, dcf_file)
  }
  if (length(project_notes)) {
    writeLines(project_notes, con = file.path(path, "PLEASE READ - Project Creation Notes"))
  }
  writeLines(hw_text, con = file.path(path, hw_name))
}
