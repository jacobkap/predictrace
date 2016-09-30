# grab data

# Downloads the files
# library(readr)

female <- read.table(url(paste("http://www2.census.gov/topics/genealogy/",
                               "1990surnames/dist.female.first",
                               sep = "")))
female$V3 <- NULL
female$V4 <- NULL
names(female) <-  c("Name", "Frequency_female")

male <- read.table(url(paste("http://www2.census.gov/topics/genealogy/",
                             "1990surnames/dist.male.first",
                             sep = "")))
male$V3 <- NULL
male$V4 <- NULL
names(male) <- c("Name", "Frequency_male")


# Download surnames file from here
surnames_race <- read_csv("app_c.csv")
surnames_race$rank <- NULL
surnames_race$cum_prop100k <- NULL
surnames_race$count <- NULL
surnames_race$prop100k <- NULL
surnames_race$pct2prace <- NULL
names(surnames_race) <- c("name", "White_percent", "Black_percent",
                          "Asian_percent", "Native_American_percent",
                          "Hispanic_percent")
surnames_race$White_percent[is.na(surnames_race$White_percent)] <- 0
surnames_race$Black_percent[is.na(surnames_race$Black_percent)] <- 0
surnames_race$Asian_percent[is.na(surnames_race$Asian_percent)] <- 0
surnames_race$Native_American_percent[
  is.na(surnames_race$Native_American_percent)] <- 0
surnames_race$Hispanic_percent[is.na(surnames_race$Hispanic_percent)] <- 0
surnames_race$White_percent[surnames_race$White_percent == "(S)"] <- 0
surnames_race$Black_percent[surnames_race$Black_percent == "(S)"] <- 0
surnames_race$Asian_percent[surnames_race$Asian_percent == "(S)"] <- 0
surnames_race$Native_American_percent[
  surnames_race$Native_American_percent == "(S)"] <- 0
surnames_race$Hispanic_percent[surnames_race$Hispanic_percent == "(S)"] <- 0
# Make numeric
surnames_race$White_percent <- as.numeric(surnames_race$White_percent)
surnames_race$Black_percent <- as.numeric(surnames_race$Black_percent)
surnames_race$Asian_percent <- as.numeric(surnames_race$Asian_percent)
surnames_race$Native_American_percent <-
  as.numeric(surnames_race$Native_American_percent)
surnames_race$Hispanic_percent <- as.numeric(surnames_race$Hispanic_percent)
surnames_race$name <- tolower(surnames_race$name)



first_name_sex <- merge(male, female, by = "Name", all = TRUE)
first_name_sex$Frequency_male[is.na(first_name_sex$Frequency_male)] <- 0
first_name_sex$Frequency_female[is.na(first_name_sex$Frequency_female)] <- 0
first_name_sex$Name <- tolower(first_name_sex$Name)
first_name_sex_male <- male
first_name_sex_female <- female


# Get social security name/gender data
path <- ("C:/Users/user/Dropbox/R_project/nameSexRace/SSN")
out.file <- ""
file.names <- dir(path, pattern = ".txt")
for (i in 1:length(file.names)) {
  file <- read.table(file.names[i],header = FALSE,
                     sep = ",", stringsAsFactors = FALSE)
  out.file <- rbind(out.file, file)
}
names(out.file) <- c("name", "gender", "count")
is(out.file$count)
out.file$count <- as.numeric(out.file$count)
out.file <- out.file[!is.na(out.file$count),]
out.file <- aggregate(count ~ name + gender, data = out.file, FUN = sum)
out.file$gender <- gsub("M", "Male", out.file$gender)
out.file$gender <- gsub("^F$", "Female", out.file$gender)

