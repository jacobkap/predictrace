# surnames_race <- get_surnames_race()
# usethis::use_data(surnames_race, internal = TRUE, overwrite = TRUE)
# usethis::use_data(surnames_race, internal = FALSE, overwrite = TRUE)

get_surnames_race <- function(){
  # https://www.census.gov/topics/population/genealogy/data/2010_surnames.html
  setwd(here::here("data-raw"))
  data <- read.csv("Names_2010Census.csv", stringsAsFactors = FALSE)
  data <-
    data %>%
    dplyr::rename(probability_white           = pctwhite,
                  probability_black           = pctblack,
                  probability_asian           = pctapi,
                  probability_american_indian = pctaian,
                  probability_2races          = pct2prace,
                  probability_hispanic        = pcthispanic) %>%
    dplyr::select(name,
                  probability_white,
                  probability_black,
                  probability_asian,
                  probability_american_indian,
                  probability_2races,
                  probability_hispanic) %>%
    dplyr::mutate_at(2:7, as.numeric) %>%
    dplyr::mutate_all(tidyr::replace_na, 0) %>%
    dplyr::mutate(probability_white = probability_white / 100,
                  probability_black = probability_black / 100,
                  probability_asian = probability_asian / 100,
                  probability_american_indian = probability_american_indian / 100,
                  probability_2races = probability_2races / 100,
                  probability_hispanic = probability_hispanic / 100,
                  name = tolower(name))

  data$likely_race <- ""
  race_columns <-
    c("probability_black",
      "probability_white",
      "probability_asian",
      "probability_american_indian",
      "probability_2races",
      "probability_hispanic")
  race_columns_permutations <- combinat::permn(race_columns)
  for (i in 1:length(race_columns_permutations)) {

    race_columns_temp <- race_columns_permutations[[i]]

    data$likely_race <- paste0(data$likely_race, ", ",
                               race_columns_temp[max.col(data[, race_columns_temp],
                                                         ties.method = "first")])

    z<- strsplit(data$likely_race, ", ")
    head(z)
    z <- sapply(z, unique, simplify = FALSE)
    z <- sapply(z, sort, simplify = FALSE)
    head(z)
    z <- sapply(z, function(x) paste(x, collapse = ", "))
    z <- gsub("^, ", "", z)
    head(z)
    #z[12092]
    data$likely_race <- z
    head(data$likely_race)

    message(i)
  }


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


