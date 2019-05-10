# surnames_race <- get_surnames_race()
# usethis::use_data(surnames_race, internal = TRUE, overwrite = TRUE)
# usethis::use_data(surnames_race, internal = FALSE, overwrite = TRUE)

get_surnames_race <- function(){
  # https://www.census.gov/topics/population/genealogy/data/2010_surnames.html
  setwd(here::here("data-raw"))
  data <- read.csv("Names_2010Census.csv", stringsAsFactors = FALSE)
  data <- dplyr::rename(data,
                        probability_white = pctwhite,
                        probability_black = pctblack,
                        probability_asian = pctapi,
                        probability_american_indian = pctaian,
                        probability_2races = pct2prace,
                        probability_hispanic = pcthispanic)
  data <- dplyr::select(data,
                        name,
                        probability_white,
                        probability_black,
                        probability_asian,
                        probability_american_indian,
                        probability_2races,
                        probability_hispanic)
  data[,2:ncol(data)] <- suppressWarnings(sapply(data[,2:ncol(data)], as.numeric))
  data <- dplyr::mutate(data,
                        probability_white = probability_white / 100,
                        probability_black = probability_black / 100,
                        probability_asian = probability_asian / 100,
                        probability_american_indian = probability_american_indian / 100,
                        probability_2races = probability_2races / 100,
                        probability_hispanic = probability_hispanic / 100)

  data$name <- tolower(data$name)
  data$likely_race <-   colnames(data)[2:6][max.col(data[, 2:6], ties.method = "first")]
  data$likely_race <- gsub("probability_", "", data$likely_race)
  data <- dplyr::select(data,
                        name,
                        likely_race,
                        probability_american_indian,
                        probability_asian,
                        probability_black,
                        probability_hispanic,
                        probability_white,
                        probability_2races)
  data <- as.data.frame(data)

  return(data)
}


