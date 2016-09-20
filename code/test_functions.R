library(httr)
library(readr)

url <-  "https://iaspub.epa.gov/"
#path <- "enviro/efservice/tri_facility/state_abbr/RI/CSV"
path <-  "enviro/efservice/tri_facility_history/state_abbr/RI/CSV"


raw.result <- GET(url = url, path = path)

content <- rawToChar(raw.result$content)

ri <- read.csv(text = content, stringsAsFactors = FALSE)

#setwd("~/Google\ Drive/epapi/")
#write_csv(ri, "temp.csv")
