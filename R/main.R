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
#' A data.frame with three or nine columns: The first column has the name as inputted,
#' the second column has the cleaned up name (no spaces or punctuation, all
#' lowercase), the third column tells the likely race of the surname. If the
#' parameter probability is false, these three columns are all that is returned.
#' Otherwise, columns 4-9 tell the specific probability that the surname
#' is each race.
#' @export
#'
#' @examples
#' predict_race("franklin")
#'
#' predict_race(c("franklin", "Washington", "Jefferson", "Sotomayor", "Liu"))
#' predict_race("franklin", probability = FALSE)
predict_race <- function(name, probability = TRUE) {

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
  data <- dplyr::left_join(data, predictrace::surnames_race, by = "name")


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
