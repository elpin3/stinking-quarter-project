library(ecmwfr)
library(tidyverse)

# Set with your user email
wf_set_key(wf_get_key(user = ""))

years <- c(seq(2021, 2026))
requestList <- list()

for (year in years){
  requestList <- append(requestList, list(list(
    dataset_short_name = "derived-era5-single-levels-daily-statistics",
    product_type = "reanalysis",
    variable = c("2m_dewpoint_temperature"),
    year = year,
    month = 1:12,
    day = 1:31,
    daily_statistic = "daily_mean",
    time_zone = "utc-04:00",
    area = c(36, -79.7, 35.8, -79.45),
    file_format = "1_hourly",
    format = "grib",
    target = paste0("2mDewTemp", year, "Data.nc")
  )))
  requestList <- append(requestList, list(list(
    dataset_short_name = "derived-era5-single-levels-daily-statistics",
    product_type = "reanalysis",
    variable = c("2m_temperature"),
    year = year,
    month = 1:12,
    day = 1:31,
    daily_statistic = "daily_mean",
    time_zone = "utc-04:00",
    area = c(36, -79.7, 35.8, -79.45),
    file_format = "1_hourly",
    format = "grib",
    target = paste0("2mTemp", year, "Data.nc")
  )))
  
  requestList <- append(requestList, list(list(
    dataset_short_name = "derived-era5-single-levels-daily-statistics",
    product_type = "reanalysis",
    variable = c("total_precipitation"),
    year = year,
    month = 1:12,
    day = 1:31,
    daily_statistic = "daily_mean",
    time_zone = "utc-04:00",
    area = c(36, -79.7, 35.8, -79.45),
    file_format = "1_hourly",
    format = "grib",
    target = paste0("precip", year, "Data.nc")
  )))
  
  requestList <- append(requestList, list(list(
    dataset_short_name = "derived-era5-single-levels-daily-statistics",
    product_type = "reanalysis",
    variable = c("10m_u_component_of_wind"),
    year = year,
    month = 1:12,
    day = 1:31,
    daily_statistic = "daily_mean",
    time_zone = "utc-04:00",
    area = c(36, -79.7, 35.8, -79.45),
    file_format = "1_hourly",
    format = "grib",
    target = paste0("10mWindU", year, "Data.nc")
  )))
  requestList <- append(requestList, list(list(
    dataset_short_name = "derived-era5-single-levels-daily-statistics",
    product_type = "reanalysis",
    variable = c("10m_v_component_of_wind"),
    year = year,
    month = 1:12,
    day = 1:31,
    daily_statistic = "daily_mean",
    time_zone = "utc-04:00",
    area = c(36, -79.7, 35.8, -79.45),
    file_format = "1_hourly",
    format = "grib",
    target = paste0("10mWindV", year, "Data.nc")
  )))
}

set2 <- tail(requestList, 1)

wf_request_batch(
  set2,
  path = "data/batYearlyClimateData/",
  time_out = 86400,
  retry = 30,
  workers = 1
)

