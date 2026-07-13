library(daymetr)

surveyDates <- read.csv("data/surveyDates.csv")

daymetData <- download_daymet(
  site = "daymet",
  lat = 35.920848,
  lon = -79.634465,
  start = 2021,
  end = 2025,
  #path = FALSE,
  force = FALSE,
  simplify = FALSE
)

weatherData <- daymetData$data

joined <- left_join(surveyDates, weatherData, by = c("julianDate" = "yday", "year"))
write.csv(joined, "data/datesWithWeather.csv", row.names = FALSE)
