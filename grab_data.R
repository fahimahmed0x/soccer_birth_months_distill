#rerun this script to get up to date data
library(tidyverse)
library(rvest)

html <- read_html("https://en.wikipedia.org/wiki/UEFA_Euro_2020_squads")

#https://rvest.tidyverse.org/articles/articles/selectorgadget.html

raw_data <- html %>%
  html_elements(".nat-fs-player th+ td") %>%
  html_text2() %>%
  as_tibble()

write_csv(raw_data, "birthdates.csv")