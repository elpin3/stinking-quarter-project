
surveyWeatherData <- read.csv("data/surveyDatesWithWeather.csv")

# Convert u and V to mph
wind_ms <- sqrt(surveyWeatherData$u10**2 + surveyWeatherData$v10**2)
surveyWeatherData$windMPH <- wind_ms *2.23694

#Calculate relative humidity
surveyWeatherData$RelativeHumidity <- RH <- 100 * (exp((17.625 * surveyWeatherData$d2m) / (243.04 + surveyWeatherData$d2m)) / exp((17.625 *surveyWeatherData$t2m) / (243.04 +surveyWeatherData$t2m)))

#Temperature in F
surveyWeatherData$tempF <- ((surveyWeatherData$t2m - 273.15) * (9/5) + 32)

#Precipiation in cm
surveyWeatherData$precip_cm <- surveyWeatherData$tp*100

necessaryInfo <- surveyWeatherData |>
  select(-c("u10", "v10", "d2m", "t2m","tp"))

rained <- necessaryInfo |>
  mutate(rainDay = case_when(precip_cm > 0 ~ TRUE,
                             .default = FALSE))

rained <- rained |>
  mutate(afterRain = lag(rainDay, default = FALSE) & !rainDay)

write.csv(rained, "data/finalWeather.csv", row.names = FALSE)