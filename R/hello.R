#' Find the gender of a name
#'
#' @param names
#' Name that you want to know the sex of
#' @param probability
#' The probability that the name is male or female
#'
#' @return
#' A dataframe with three columns: The first column has the name as inputted,
#' the second column has the cleaned up name (no spaces or punctuation,
#' first letter is capitalized), the final column tells the sex of the name
#' @export
#'
#' @examples
#' find_sex("Benjamin")
#' find_sex("Benjamin", probability = TRUE)
#'
#' find_sex(c("Benjamin", "Ge orge", "thom-as", "son-ya", "elena", "RUTH",
#'            "Ivory", "Jessie"))
#' find_sex(c("Benjamin", "Ge orge", "thom-as", "son-ya", "elena", "RUTH",
#'            "Ivory", "Jessie"),  probability = TRUE)
#'
#' example <- data.frame(names =
#'         c("Benjamin", "Ge orge", "thom-as", "son-ya", "elena", "RUTH"))
#' find_sex(example$names)
find_sex <- function(names, probability = FALSE) {

  simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1,1)), substring(s, 2),
          sep = "", collapse = " ")
  }

  names2 <- tolower(names)
  names2 <- gsub("[[:punct:]]", "", names2)
  names2 <- gsub(" ", "", names2)

  return_frame <- data.frame(names)
  return_frame$clean_names <- names2
  return_frame$clean_names <- sapply(return_frame$clean_names,
                                     simpleCap)
  return_frame$sex <- NA

  subset_first <- gender_names[gender_names$name == names2[1],][1,]
  if (is.na(subset_first$male_prob)) {
    return_frame$sex[1] <- NA
  } else if (subset_first$male_prob > subset_first$female_prob) {
    return_frame$sex[1] <- "Male"
    if (probability) {
      return_frame$probability[1] <- subset_first$male_prob
    }
  } else if (subset_first$male_prob < subset_first$female_prob) {
    return_frame$sex[1] <- "Female"
    if (probability) {
      return_frame$probability[1] <- subset_first$female_prob
    }
  }

  if (length(names) > 1) {
    for (i in 2:length(names)) {
      subset_first <- gender_names[gender_names$name == names2[i],][1,]
      if (is.na(subset_first$male_prob)) {
        return_frame$sex[i] <- NA
      } else if (subset_first$male_prob > subset_first$female_prob) {
        return_frame$sex[i] <- "Male"
        if (probability) {
          return_frame$probability[i] <- subset_first$male_prob
        }
      } else if (subset_first$male_prob < subset_first$female_prob) {
        return_frame$sex[i] <- "Female"
        if (probability) {
          return_frame$probability[i] <- subset_first$female_prob
        }
      }
    }
  }

  return(return_frame)
}


#' Find the race of a surname
#'
#' @param surnames
#' Surname that you want to know the race of
#'
#' @param probability
#' The probability that the surname is the selected race
#'
#' @return
#' A dataframe with three columns: The first column has the name as inputted,
#' the second column has the cleaned up name (no spaces or punctuation,
#' first letter is capitalized), the final column tells the race of the name
#' @export
#'
#' @examples
#' find_race("franklin")
#' find_race("franklin", probability = TRUE)
#'
#' find_race(c("franklin", "Washington", "Jefferson", "Sotomayor", "Liu"))
#'
#' find_race(c("franklin", "Washington", "Jefferson", "Sotomayor", "Liu"),
#'              probability = TRUE)
#' example <- data.frame(surnames = c("frank'.lin",
#'                                    "washing-ton", "JEFFERSON", "A dams",
#'                                    "Liu", "Sotomayor"))
#' find_race(example$surnames)
find_race <- function(surnames, probability = FALSE, all = FALSE) {

  simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1,1)), substring(s, 2),
          sep = "", collapse = " ")
  }


  surnames2 <- tolower(surnames)
  surnames2 <- gsub("[[:punct:]]", "", surnames2)
  surnames2 <- gsub(" ", "", surnames2)
  return_frame <- data.frame(surnames)
  return_frame$clean_surnames <- surnames2
  return_frame$clean_surnames <- sapply(return_frame$clean_surnames,
                                        simpleCap)
  return_frame$race <- NA


  subset_first <- surnames_race[surnames_race$name == surnames2[1],][1,]
  max_value <- names(sort(apply(subset_first[2:6], 2,
                                function(x) max(x, na.rm = FALSE)),
                          decreasing = TRUE)[1])
  if (is.na(max_value)) {
    return_frame$race[1] <- NA
  } else (return_frame$race[1] <- gsub("(.*)_percent", "\\1", max_value))
  if (probability) {
    return_frame$probability[1] <- as.numeric(
           sort(apply(subset_first[2:6], 2,
                function(x) max(x, na.rm = FALSE)),
                decreasing = TRUE)[1])
  }

  if (length(surnames) > 1) {
    for (i in 2:length(surnames)) {
      subset_first <- surnames_race[surnames_race$name == surnames2[i],][1,]
      max_value <- names(sort(apply(subset_first[2:6], 2,
                                    function(x) max(x, na.rm = FALSE)),
                              decreasing = TRUE)[1])
      if (is.na(max_value)) {
        return_frame$race[i] <- NA
      } else (return_frame$race[i] <- gsub("(.*)_percent", "\\1", max_value))
      if (probability) {
        return_frame$probability[i] <- as.numeric(
          sort(apply(subset_first[2:6], 2,
                     function(x) max(x, na.rm = FALSE)),
               decreasing = TRUE)[1])
      }
    }
  }

  return(return_frame)
}
