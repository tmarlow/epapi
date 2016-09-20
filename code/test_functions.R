library(httr)
library(readr)
library(stringr)

url <-  "https://iaspub.epa.gov/"
#path <- "enviro/efservice/tri_facility/state_abbr/RI/CSV"
path <-  "enviro/efservice/tri_facility_history/state_abbr/RI/CSV"


raw.result <- GET(url = url, path = path)

content <- rawToChar(raw.result$content)

ri <- read.csv(text = content, stringsAsFactors = FALSE)

#setwd("~/Google\ Drive/epapi/")
#write_csv(ri, "temp.csv")



tri <- function(state_abbreviation = "", year = ""){
    url <-  "https://iaspub.epa.gov/"
    api <- "enviro/efservice/tri_facility_history/"
    state <- str_c("state_abbr/", state_abbreviation)
    year <- str_c("/REPORTING_YEAR/", year)
    path <- str_c(api, state, year, "/CSV")
    raw <- GET(url = url, path = path)
    content <- rawToChar(raw$content)
    df <- read.csv(text = content, stringsAsFactors = FALSE)
    return(df)
}

ri90 <- tri("RI", "1990")
