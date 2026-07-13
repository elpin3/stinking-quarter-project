library(ncdf4)
library(terra)
library(tidyverse)

surveyDates <- c(seq(as.Date("01-01-2021", format = "%m-%d-%Y"), 
                   as.Date("12-31-2026", format = "%m-%d-%Y")))

surveyDates <- data.frame("allDates" = as.Date(surveyDates))

years <- c(seq(2021, 2026))
loadInOrder <- c("u10", "v10", "d2m", "t2m", "tp")
allWeatherData <- list()
for(year in years){
  allFiles <- list.files(path = paste0("data/batYearlyClimateData/", year), pattern = "\\.nc$", full.names = TRUE)
  ncData <- lapply(allFiles, nc_open)
  
  runningList <- list()
  
  for(i in seq(length(loadInOrder))){
    varValues <- c(ncvar_get(ncData[[i]], loadInOrder[i]))
    runningList[[loadInOrder[i]]] <- varValues
  }
  weather <- bind_rows(data.frame(), runningList)
  if(year != 2026){
    weather$date <- c(seq(as.Date(paste0(year, "-01-01")), as.Date(paste0(year, "-12-31"))))
  }else{
    weather$date <- c(seq(as.Date(paste0(year, "-01-01")), as.Date(paste0(year, "-07-06"))))
  }
  allWeatherData[[length(allWeatherData)+1]] <- weather
  write.csv(weather, paste0("data/batClimateData/", year, ".csv"), row.names = FALSE)
}

allTogether <- do.call(rbind, allWeatherData)
write.csv(allTogether, "data/surveyYearlyWithData.csv", row.names = FALSE)
