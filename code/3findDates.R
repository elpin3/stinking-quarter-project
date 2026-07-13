library(dplyr)

findSelections <- read.csv("data/finalWeather.csv")

uniqueWindows <- findSelections |>
  select(window_num, julianWeek, year) |>
  unique()

sampleDays <- findSelections |>
  group_by(window_num, julianWeek, year) |>
  arrange(desc(afterRain), desc(tempF), RelativeHumidity, allDates, .by_group = TRUE) |>
  slice(1) |>
  ungroup() |>
  arrange(desc(allDates)) |>
  select(-c(month_num, window_num, julianDate))

write.csv(sampleDays, "data/selectedSampleDays.csv")
