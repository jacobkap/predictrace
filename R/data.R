#' Surnames and number of people of each race with that surname.
#'
#' A dataset containing over 167 thousands surnames and the
#' number of people of each race with that surname.
#'
#' @format A data frame with 167,408 rows and 8 variables:
#' \describe{
#'   \item{name}{Surname}
#'   \item{likely_race}{The most likely race based on the probability of each race}
#'   \item{probability_american_indian}{Probability that the surname is American Indian}
#'   \item{probability_asian}{Probability that the surname is Asian}
#'   \item{probability_black}{Probability that the surname is Black}
#'   \item{probability_hispanic}{Probability that the surname is Hispanic}
#'   \item{probability_white}{Probability that the surname is White}
#'   \item{probability_2races}{Probability that the surname is two or more races}
#'   ...
#' }
#' @source \url{https://www.census.gov/topics/population/genealogy/data/2010_surnames.html} \url{https://www.census.gov/topics/population/genealogy/data/2000_surnames.html}
#'
"surnames_race"
