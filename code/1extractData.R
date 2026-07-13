library(ncdf4)
library(terra)
library(tidyverse)

surveyDates <- read.csv("data/surveyDates.csv")
surveyDates$allDates <- as.Date(surveyDates$allDates)
years <- c(seq(2021, 2026))
loadInOrder <- c("u10", "v10", "d2m", "t2m", "tp")
allWeatherData <- list()
for(year in years){
  allFiles <- list.files(path = paste0("data/climateData/", year), pattern = "\\.nc$", full.names = TRUE)
  ncData <- lapply(allFiles, nc_open)
  
  runningList <- list()
  
  for(i in seq(length(loadInOrder))){
    varValues <- c(ncvar_get(ncData[[i]], loadInOrder[i]))
    runningList[[loadInOrder[i]]] <- varValues
  }
  weather <- bind_rows(data.frame(), runningList)
  if(year != 2026){
    weather$date <- c(seq(as.Date(paste0(year, "-01-01")), as.Date(paste0(year, "-06-30"))))
  }else{
    weather$date <- c(seq(as.Date(paste0(year, "-01-01")), as.Date(paste0(year, "-06-21"))))
  }
  allWeatherData[[length(allWeatherData)+1]] <- weather
  write.csv(weather, paste0("data/yearlyClimateData/", year, ".csv"), row.names = FALSE)
}


allTogether <- do.call(rbind, allWeatherData)
onlyRelevantSurveyDates <- left_join(surveyDates, allTogether, by = c("allDates" = "date"))
write.csv(onlyRelevantSurveyDates, "data/surveyDatesWithWeather.csv", row.names = FALSE)
