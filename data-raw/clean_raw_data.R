# # surnames_race <- get_surnames_race()
#
# # https://www.census.gov/topics/population/genealogy/data/2010_surnames.html
# data <- read.csv("data-raw/Names_2010Census.csv")
# data <- clean_data(data)
# data_2000 <- readxl::read_excel("data-raw/app_c.xlsx", sheet = 1)
# data_2000 <- clean_data(data_2000)
# data <-
#   data %>%
#   dplyr::bind_rows(data_2000)
# surnames_race <- get_surnames_race(data)
#
# first_names <- readxl::read_excel("data-raw/firstnames.xlsx", sheet = 2)
# names(first_names) <- gsub("^obs$", "count", names(first_names))
# names(first_names) <- gsub("^firstname$", "name", names(first_names))
# first_names <- clean_data(first_names)
# first_names_race <- get_surnames_race(first_names)
#
#
#
# first_names_gender <- get_ssn_gender()
#
# usethis::use_data(first_names_race, surnames_race, first_names_gender,
#                   internal = TRUE, overwrite = TRUE)
# usethis::use_data(first_names_race, surnames_race, first_names_gender,
#                   internal = FALSE, overwrite = TRUE)
# #
# get_surnames_race <- function(data){
#
#   data <-
#     data %>%
#     dplyr::group_by(name) %>%
#     dplyr::summarize_all(sum) %>%
#     dplyr::mutate(probability_white           = count_white / count,
#                   probability_black           = count_black / count,
#                   probability_asian           = count_asian / count,
#                   probability_american_indian = count_american_indian / count,
#                   probability_2races          = count_2races / count,
#                   probability_hispanic        = count_hispanic / count) %>%
#     dplyr::arrange(dplyr::desc(count)) %>%
#     dplyr::filter(name != "all other names") %>%
#     dplyr::select(-count_white,
#                   -count_black,
#                   -count_asian,
#                   -count_american_indian,
#                   -count_2races,
#                   -count_hispanic,
#                   -count
#     )
#
#   data$likely_race <- ""
#   race_columns <-
#     c("probability_black",
#       "probability_white",
#       "probability_asian",
#       "probability_american_indian",
#       "probability_2races",
#       "probability_hispanic")
#   race_columns_permutations <- combinat::permn(race_columns)
#   message(length(race_columns_permutations))
#   for (i in 1:length(race_columns_permutations)) {
#
#     race_columns_temp <- race_columns_permutations[[i]]
#     data$likely_race <- paste0(data$likely_race, ", ",
#                                race_columns_temp[max.col(data[, race_columns_temp],
#                                                          ties.method = "first")])
#
#     z <- strsplit(data$likely_race, ", ")
#     head(z)
#     z <- sapply(z, unique, simplify = FALSE)
#     z <- sapply(z, sort, simplify = FALSE)
#     head(z)
#     z <- sapply(z, function(x) paste(x, collapse = ", "))
#     z <- gsub("^, ", "", z)
#     head(z)
#     #z[12092]
#     data$likely_race <- z
#     head(data$likely_race)
#
#     message(i)
#   }
#
#
#   data$likely_race <- gsub("probability_", "", data$likely_race)
#   data <- dplyr::select(data,
#                         name,
#                         likely_race,
#                         probability_american_indian,
#                         probability_asian,
#                         probability_black,
#                         probability_hispanic,
#                         probability_white,
#                         probability_2races) %>%
#     dplyr::mutate_if(is.numeric, round, 4)
#   data <- as.data.frame(data)
#
#   return(data)
# }
#
# clean_data <- function(data) {
#   data <-
#     data %>%
#     dplyr::rename(probability_white           = pctwhite,
#                   probability_black           = pctblack,
#                   probability_asian           = pctapi,
#                   probability_american_indian = pctaian,
#                   probability_2races          = pct2prace,
#                   probability_hispanic        = pcthispanic) %>%
#     dplyr::select(name,
#                   count,
#                   probability_white,
#                   probability_black,
#                   probability_asian,
#                   probability_american_indian,
#                   probability_2races,
#                   probability_hispanic) %>%
#     dplyr::mutate_at(c("probability_white",
#                        "probability_black",
#                        "probability_black",
#                        "probability_asian",
#                        "probability_american_indian",
#                        "probability_2races",
#                        "probability_hispanic"), as.numeric) %>%
#     dplyr::mutate_all(tidyr::replace_na, 0) %>%
#     dplyr::mutate(probability_white = probability_white / 100,
#                   probability_black = probability_black / 100,
#                   probability_asian = probability_asian / 100,
#                   probability_american_indian = probability_american_indian / 100,
#                   probability_2races = probability_2races / 100,
#                   probability_hispanic = probability_hispanic / 100,
#                   name = tolower(name)) %>%
#     dplyr::mutate(count_white = probability_white * count,
#                   count_black = probability_black * count,
#                   count_asian = probability_asian * count,
#                   count_american_indian = probability_american_indian * count,
#                   count_2races = probability_2races * count,
#                   count_hispanic = probability_hispanic * count) %>%
#     dplyr::select(-probability_white,
#                   -probability_black,
#                   -probability_black,
#                   -probability_asian,
#                   -probability_american_indian,
#                   -probability_2races,
#                   -probability_hispanic)
#   return(data)
# }
#

#
# get_ssn_gender <- function(){
#   # Get social security name/gender data
#   files <- list.files("data-raw", pattern = "txt")
#   data  <- data.frame()
#   for (i in 1:length(files)) {
#     temp <- read.table(paste0("data-raw/", files[i]), header = FALSE,
#                        sep = ",")
#     data <- dplyr::bind_rows(data, temp)
#   }
#   names(data) <- c("name", "gender", "count")
#   data$gender <- gsub("^M$", "male", data$gender)
#   data$gender <- gsub("^F$", "female", data$gender)
#
#   data <-
#     data %>%
#     dplyr::group_by(name,
#                     gender) %>%
#     dplyr::summarize(count = sum(count)) %>%
#     dplyr::arrange(name) %>%
#     dplyr::ungroup() %>%
#     dplyr::mutate(name = tolower(name))
#
#
#   data <- data.frame(reshape::cast(data,
#                                   name ~ gender, value = c("count"), fun = sum)) %>%
#     dplyr::mutate(total              = female + male,
#                   probability_male   = male / total,
#                   probability_female = female / total) %>%
#     dplyr::select(-female,
#                   -male,
#                   -total)
#
#   data$likely_gender <- "female"
#   data$likely_gender[data$probability_male >  data$probability_female] <- "male"
#   data$likely_gender[data$probability_male == data$probability_female] <- "female, male"
#   return(data)
# }
