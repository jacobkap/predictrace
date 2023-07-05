#' Find the race of a surname or first name
#'
#' The surname data comes from the United States Census. The first name
#' data comes from Tzioumis (2018, <dx.doi.org/10.1038/sdata.2018.25>)
#'
#' @param name
#' String or vector of strings of surname or first name that you want to know the race of.
#' @param probability
#' If TRUE (default) will provide columns for each race with the probability
#' that the surname is of that race. If FALSE, will only return the name,
#' the match-name from the Census data, and the most likely race.
#' @param surname
#' If TRUE (default) will return the race based on the inputted name being a surname.
#' If FALSE, will return the race based on the inputted name being a first name.
#'
#' @return
#' A data.frame with three or nine columns: The first column has the name as inputted,
#' the second column has the cleaned up name (no spaces or punctuation, all
#' lowercase), the third column tells the likely race of the surname or first name
#' (if there are multiple races with the same probability of a match, it will be
#' a string with each race separated by a comma). If the
#' parameter probability is false, these three columns are all that is returned.
#' Otherwise, columns 4-9 tell the specific probability that the surname or first name
#' is each race.
#' @export
#'
#' @examples
#' predict_race("franklin")
#'
#' predict_race(c("franklin", "Washington", "Jefferson", "Sotomayor", "Liu"))
#' predict_race("franklin", probability = FALSE)
#' predict_race("jacob", probability = FALSE, surname = FALSE)
#' predict_race("jacob", probability = TRUE, surname = FALSE)
predict_race <- function(name, probability = TRUE, surname = TRUE) {

  if (!is.character(name)) {
    stop("name must be a character type.")
  }

  if (is.numeric(probability) ||
      length(probability) != 1 ||
      !probability %in% c(TRUE, FALSE)) {
    stop("probability must either be TRUE or FALSE.")
  }

  data <- data.frame(old_name = name,
                     name     = name)

  data$name <- tolower(data$name)
  data$name <- gsub("[[:punct:]]| ", "", data$name)
  if (surname) {
    data <- dplyr::left_join(data, predictrace::surnames_race, by = "name")
  } else {
    data <- dplyr::left_join(data, predictrace::first_names_race, by = "name")
  }


  names(data) <- gsub("^name$", "match_name", names(data))
  names(data) <- gsub("^old_name$", "name", names(data))
  if (probability == FALSE) {
    data <- data[, c("name",
                     "match_name",
                     "likely_race")]
  } else {
    data <- data[, c("name",
                     "match_name",
                     "likely_race",
                     "probability_american_indian",
                     "probability_asian",
                     "probability_black",
                     "probability_hispanic",
                     "probability_white",
                     "probability_2races")]
  }
  data <- data.frame(data, stringsAsFactors = FALSE)
  data$name <- as.character(data$name)
  return(data)
}




#' Find the gender of a first name
#'
#' The surname data comes from the United States Social Security Administration (SSA).
#' This data has the number of people with that name that are identified as female
#' or male so the probability female/male is the proportion of all people with that
#' name that are female/male. SSA data is available annually from 1880-2019, this
#' aggregates all years together.
#'
#' @param name
#' String or vector of strings of  the first name that you want to know the gender of.
#' @param probability
#' If TRUE (default) will provide columns for each race with the probability
#' that the first name is of that gender If FALSE, will only return the name,
#' the match-name from the SSA data, and the most likely gender.
#'
#' @return
#' A data.frame with three or nine columns: The first column has the name as inputted,
#' the second column has the cleaned up name (no spaces or punctuation, all
#' lowercase), the third column tells the likely gender of the first name
#' (if there are multiple genders with the same probability of a match, it will be
#' a string with each race separated by a comma). If the
#' parameter probability is false, these three columns are all that is returned.
#' Otherwise, columns 4-5 tell the specific probability that the surname is female
#' or male.
#' @export
#'
#' @examples
#' predict_gender("tyrion")
#'
#' predict_gender(c("harry", "ron", "hermione", "DEAN", "NEVILLE", "Cho"))
#' predict_gender("franklin", probability = FALSE)
#' predict_gender("jacob", probability = FALSE)
#' predict_gender("jacob", probability = TRUE)
predict_gender <- function(name, probability = TRUE) {

  if (!is.character(name)) {
    stop("name must be a character type.")
  }

  if (is.numeric(probability) ||
      length(probability) != 1 ||
      !probability %in% c(TRUE, FALSE)) {
    stop("probability must either be TRUE or FALSE.")
  }

  data <- data.frame(old_name = name,
                     name     = name)

  data$name <- tolower(data$name)
  data$name <- gsub("[[:punct:]]| ", "", data$name)
  data <- dplyr::left_join(data, predictrace::first_names_gender, by = "name")


  names(data) <- gsub("^name$", "match_name", names(data))
  names(data) <- gsub("^old_name$", "name", names(data))
  if (probability == FALSE) {
    data <- data[, c("name",
                     "match_name",
                     "likely_gender")]
  } else {
    data <- data[, c("name",
                     "match_name",
                     "likely_gender",
                     "probability_female",
                     "probability_male")]
  }
  data      <- data.frame(data, stringsAsFactors = FALSE)
  data$name <- as.character(data$name)
  return(data)
}

.onAttach <- function(libname, pkgname) {
  package_citation <- "Kaplan, J (2023). predictrace: Predict the Race and Gender of a Given Name Using Census and Social Security Administration Data. Version 2.0.1. URL: https://github.com/jacobkap/predictrace, https://jacobkap.github.io/predictrace/."
  packageStartupMessage("Thank you for using predictrace!")
  packageStartupMessage("To acknowledge our work, please cite the package:")
  packageStartupMessage(package_citation)
}

