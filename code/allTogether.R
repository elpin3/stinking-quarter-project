
# Gets dates of interest (2021-2026)
source("code/0makeDates.R")

# Pulls data from daymetr (2021 - 2025)
#source("code/0pullData.R")

# Pull CDS data DON'T RUN UNLESS NECESSARRY (2021-2026)
#source("code/0pullCDS.R")

# Pull CDS entire year DON'T RUN UNLESS NECESSARY (2021-2026)
# source("code/0pullCDSEntireYear.R")

# YOU MUST MANUALLY ORGANIZE AND SORT THE DATA
# extract data from CDS - amphibian only
source("code/1extractData.R")

# extract data from CDS - entire year
source("code/1extractYearCDSData.R")

# Calculates weather and simplifies rain to presence vs absence
source("code/2calculateWeather.R")

# Calculates weather and simplifies rain to presence vs absence - entire Year
source("code/2calculateYearWeather.R")

# Calculates weather and simplifies rain to presence vs absence - yearly bat data


# Determines dates for each survey
source("code/3findDates.R")
