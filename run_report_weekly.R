library(googlesheets); library(tidyverse)

## Read the totals sheet into R
sheet <- gs_title("Gate_Test") %>% gs_read(ws = "Totals", col_types = "Diiiii")

## Get the last week's worth of observations
wk_end <- today(tzone = "America/New_York")
wk_begin <- wk_end - days(6)

this_week <- filter(sheet, Date %within% interval(wk_begin, wk_end))

## Plot daily activity totals
ggplot(this_week, aes(x = Date, y = Daily.count)) + geom_col(aes(fill = Daily.count))

## Transform the data for interval plotting
this_week <- this_week %>% select(-Daily.count) %>%
    gather(2:5, key = "Interval", value = "Count")

## Plot counts for each interval by date


