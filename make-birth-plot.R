library(tidyverse)
library(skimr)
library(lubridate)

birthdates <- read_csv("birthdates.csv",
                       col_types = cols(value = col_character()))

birth_plot <- birthdates %>%
  mutate(birth_date = str_sub(value, 2, 11)) %>%
  mutate(birth_date = parse_date(birth_date)) %>%
  mutate(raw_month = months(birth_date)) %>%
  mutate(month = parse_factor(raw_month, levels = month.name)) %>%
  group_by(month) %>%
  summarize(total = n()) %>%
  ggplot(mapping = aes(x = fct_rev(month), y = total)) +
  geom_col() +
  coord_flip() +
  theme_classic() +
  labs(title = "Birth Months of UEFA Euro 2020 Soccer Players",
       subtitle = "Most of the UEFA Euro 2020 soccer players are born in March",
       x = "Month",
       y = "Number of Players",
       caption = "Wikipedia")

write_rds(birth_plot, "birth-plot.rds")