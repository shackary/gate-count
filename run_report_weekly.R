library(googlesheets); library(tidyverse); library(lubridate)

## Read the totals sheet into R
sheet <- gs_title("Gate_Test") %>% gs_read(ws = "Totals", col_types = "Diiiii")
closeAllConnections()

## Get the last week's worth of observations
wk_end <- today(tzone = "America/New_York")
wk_begin <- wk_end - days(6)

this_week <- filter(sheet, Date %within% interval(wk_begin, wk_end))

## Plot daily activity totals
ggplot(this_week, aes(x = Date, y = Daily.count)) + geom_col(aes(fill = Date))

## Transform the data for interval plotting
this_week <- this_week %>% select(-Daily.count) %>%
    gather(2:5, key = "Interval", value = "Count")

## Need to set factor levels so the time intervals will display in the right order 
this_week$Interval <- factor(this_week$Interval,
                             levels = c("8-12", "12-5", "5-10", "10-2"))

## Plot counts for each interval by date

ggplot(this_week, (aes(x = Interval, y = Count, group = Date))) + geom_col(aes(fill = Date), position = "dodge")

