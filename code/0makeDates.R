library(tidyverse)
# 2021 - 2026
allDates <- seq(as.Date("2021-01-01"), as.Date("2026-12-31"))

dates <- as.data.frame(allDates)
dates$noYear <- as.Date(format(dates$allDates, "%m-%d"), format = "%m-%d")

window1 <- c(seq(as.Date("01-15", format = "%m-%d"), as.Date("02-28", format = "%m-%d")))
window2 <- c(seq(as.Date("03-15", format = "%m-%d"), as.Date("04-30", format = "%m-%d")))
window3 <- c(seq(as.Date("05-15", format = "%m-%d"), as.Date("06-30", format = "%m-%d")))
windows <- c(window1, window2, window3)

#windowsDF <- data.frame(date = window1)
#windowsDF$days_elapsed <- as.numeric(windowsDF$date - min(windowsDF$date))
#windowsDF$period_group <- (windowsDF$days_elapsed %/% 7) + 1
#groupOrder <- c(windowsDF$period_group, (windowsDF$period_group + 7), (windowsDF$period_group + 14))

#order <- rep(groupOrder, times = 5)
#order <- c(windowsDF$period_group, order, "")

filteredDates <- dates |>
  filter(noYear %in% windows) |>
  # Remove window 1 and 2 from 2021 data
  filter(allDates > as.Date("2021-06-01")) |>
  select(-noYear)

#Determines section window
filteredDates <- filteredDates |>
  mutate(
    month_num = month(allDates), 
    # Classify into windows
    window_num = case_when(
      month_num >= 1 & month_num <= 2  ~ 1,
      month_num >= 3 & month_num <= 4  ~ 2,
      month_num >= 5 & month_num <= 6 ~ 3
    )
  )

#Adds julian day
filteredDates$julianDate <- format(filteredDates$allDates, "%j")
filteredDates$year <- format(filteredDates$allDates, "%Y")

#adds julian week
# ISO 8601 (monday start)
filteredDates$julianWeek <- strftime(filteredDates$allDates, format = "%V")

# Sunday start
#sunday <- strftime(filteredDates$allDates, format = "%U")

write.csv(filteredDates, "data/surveyDates.csv", row.names = FALSE)



