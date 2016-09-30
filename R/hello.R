
#' Title
#'
#' @param names
#'
#' @return
#' A dataframe with three columns: The first column has the name as inputted,
#' the second column has the cleaned up name (no spaces or punctuation,
#' first letter is capitalized), the final column tells the sex of the name
#' @export
#'
#' @examples
#' find_sex("Benjamin")
#' find_sex(c("Benjamin", "Ge orge", "thom-as", "son-ya", "elena", "RUTH"))
#' example <- data.frame(names =
#'         c("Benjamin", "Ge orge", "thom-as", "son-ya", "elena", "RUTH"))
#' find_sex(example$names)

find_sex <- function(names) {

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

  subset_first <- first_name_sex[first_name_sex$Name == names2[1],][1,]
  if (is.na(subset_first$Frequency_male)) {
    return_frame$sex[1] <- NA
  } else if (subset_first$Frequency_male > subset_first$Frequency_female) {
    return_frame$sex[1] <- "Male"
  } else if (subset_first$Frequency_male < subset_first$Frequency_female) {
    return_frame$sex[1] <- "Female"
  }

  if (length(names) > 1) {
    for (i in 2:length(names)) {
      subset_first <- first_name_sex[first_name_sex$Name == names2[i],][1,]
      if (is.na(subset_first$Frequency_male)) {
        return_frame$sex[i] <- NA
      } else if (subset_first$Frequency_male > subset_first$Frequency_female) {
        return_frame$sex[i] <- "Male"
      } else if (subset_first$Frequency_male < subset_first$Frequency_female) {
        return_frame$sex[i] <- "Female"
      }
    }
  }

  return(return_frame)
}


#' Title
#'
#' @param surnames
#'
#' @return
#' A dataframe with three columns: The first column has the name as inputted,
#' the second column has the cleaned up name (no spaces or punctuation,
#' first letter is capitalized), the final column tells the race of the name
#' @export
#'
#' @examples
#' find_race("franklin")
#' find_race(c("franklin", "Washington", "Jefferson", "Sotomayor"))
#' example <- data.frame(surnames = c("frank'.lin",
#'                                    "washing-ton", "JEFFERSON", "A dams"))
#' find_race(example$surnames)
find_race <- function(surnames) {

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

  if (length(surnames) > 1) {
    for (i in 2:length(surnames)) {
      subset_first <- surnames_race[surnames_race$name == surnames2[i],][1,]
      max_value <- names(sort(apply(subset_first[2:6], 2,
                                    function(x) max(x, na.rm = FALSE)),
                              decreasing = TRUE)[1])
      if (is.na(max_value)) {
        return_frame$race[i] <- NA
      } else (return_frame$race[i] <- gsub("(.*)_percent", "\\1", max_value))
    }
  }

  return(return_frame)
}


