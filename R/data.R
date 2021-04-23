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


#' Surnames and number of people of each race with that first name
#'
#' A dataset containing over 167 thousands surnames and the
#' number of people of each race with that surname. Citation
#' for this data: Tzioumis, Konstantinos (2018) Demographic aspects of first names, Scientific Data, 5:180025 [dx.doi.org/10.1038/sdata.2018.25].
#'
#' @format A data frame with 4,251 rows and 8 variables:
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
#' @source \url{https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/TYJKEZ}
#'
"first_names_race"


#' Surnames and number of people of each race with that first name
#'
#' A dataset containing almost 100,000 first names and the proportion of people
#' with that first name that are female and male.
#'
#' @format A data frame with 99,444 rows and 4 variables:
#' \describe{
#'   \item{name}{The person's first name}
#'   \item{probability_male}{Probability that the first is male}
#'   \item{probability_female}{Probability that the first name is female}
#'   \item{likely_gender}{The most likely gender based on the probability of each gender}
#'   ...
#' }
#' @source \url{https://www.ssa.gov/oact/babynames/limits.html}
#'
"first_names_gender"
