library(readr); library(lubridate); library(googlesheets)

## Set hardware ID
hwid <- "TS"

## Set time zone
tz <- "America/New_York"

## Read log file
counts <- read_lines("gate_test.txt", skip_empty_rows = T)

## Convert to time objects
counts <- as_datetime(as.integer(counts), tz = tz)

## Define the time points we want to use
## 8am
t1 <- today(tzone = tz) - days(1)
hour(t1) <- 8
t1 <- force_tz(t1, tzone = tz)

## 12pm
t2 <- t1 + hours(4)

## 5pm
t3 <- t2 + hours(5)

## 10pm
t4 <- t3 + hours(5)

## 2am
t5 <- t4 + hours(4)

## Get the hits for the day
daily_traffic <- counts[counts %within% interval(t1, t5)]

## Generate counts for the intervals
daily_count <- length(daily_traffic)
i1 <- sum(daily_traffic %within% interval(t1,t2))
i2 <- sum(daily_traffic %within% interval(t2,t3))
i3 <- sum(daily_traffic %within% interval(t3,t4))
i4 <- sum(daily_traffic %within% interval(t4,t5))

## Open our google sheet
sheet <- gs_title("Gate_Test")

## Append the new data to the end of the sheet
gs_add_row(sheet, ws = hwid, input = data.frame(today(tzone = tz) - days(1), daily_count, i1, i2, i3, i4))

## Clean up
closeAllConnections()
