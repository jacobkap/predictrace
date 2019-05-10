#' Find the race of a surname
#'
#' @param name
#' String or vector of strings of surname that you want to know the race of.
#' @param probability
#' If TRUE (default) will provide columns for each race with the probability
#' that the surname is of that race. If FALSE, will only return the name,
#' the match-name from the Census data, and the most likely race.
#'
#' @return
#' A data.frame with three columns: The first column has the name as inputted,
#' the second column has the cleaned up name (no spaces or punctuation,
#' first letter is capitalized), the final column tells the race of the name
#' @export
#'
#' @examples
#' race("franklin")
#'
#' race(c("franklin", "Washington", "Jefferson", "Sotomayor", "Liu"))
#' race("franklin", probability = FALSE)
race <- function(name, probability = TRUE) {

  if (!is.character(name)) {
    stop("name must be a character type.")
  }

  if (is.numeric(probability) ||
      length(probability) != 1 ||
      !probability %in% c(TRUE, FALSE)) {
    stop("probability must either be TRUE or FALSE.")
  }

  data <- data.frame(old_name = name,
                     name = name)

  data$name <- tolower(data$name)
  data$name <- gsub("[[:punct:]]| ", "", data$name)
  data <- dplyr::left_join(data, surnames_race, by = "name")



  data <- dplyr::rename(data, name = old_name,
                        match_name = name)
  if (probability == FALSE) {
    data <- dplyr::select(data,
                          name,
                          match_name,
                          likely_race)
  } else {
    data <- dplyr::select(data,
                          name,
                          match_name,
                          dplyr::everything())
  }
  data <- data.frame(data, stringsAsFactors = FALSE)
  data$name <- as.character(data$name)
  return(data)
}
