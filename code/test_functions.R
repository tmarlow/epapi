library(httr)
library(readr)
library(stringr)

url <-  "https://iaspub.epa.gov/"
#path <- "enviro/efservice/tri_facility/state_abbr/RI/CSV"
#path <-  "enviro/efservice/tri_facility_history/state_abbr/RI/CSV"

path <- "enviro/efservice/tri_reporting_form/TRI_FACILITY_ID/02808BRDFR1712B/CSV"

path <- "enviro/efservice/tri_release_qty/DOC_CTRL_NUM/1393075454621/CSV"

raw.result <- GET(url = url, path = path)
content <- rawToChar(raw.result$content)
ri <- read.csv(text = content, stringsAsFactors = FALSE)

setwd("~/Google\ Drive/epapi/")
write_csv(df3, "temp.csv")



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

## Get a list of facility ids from the resulting df

ids <- unique(ri90$tri_facility_history.TRI_FACILITY_ID)

## foreach facility id, query tri_reporting form
## first need to define a new function for this to use in lapply
tri_reporting_form <- function(id){
    url <-  "https://iaspub.epa.gov/"
    api <- "enviro/efservice/tri_reporting_form/TRI_FACILITY_ID/"
    path <- str_c(api, id, "/CSV")
    raw <- GET(url = url, path = path)
    content <- rawToChar(raw$content)
    df <- read.csv(text = content, stringsAsFactors = FALSE)
    return(df)
}

df2 <- lapply(ids, tri_reporting_form)
df3 <- do.call(rbind, df2)


#doc_nums <- unique(df3$tri_reporting_form.DOC_CTRL_NUM)
#tri_release_qty <- function(doc_ids){
##     url <-  "https://iaspub.epa.gov/"
##     api <- "enviro/efservice/tri_release_qty/DOC_CTRL_NUM/"
##     path <- str_c(api, doc_ids, "/CSV")
##     raw <- GET(url = url, path = path)
##     content <- rawToChar(raw$content)
##     df <- read.csv(text = content, stringsAsFactors = FALSE)
##     return(df)
## }

#df4 <- lapply(doc_nums, tri_release_qty) # this didn't work! Failed!
#df5 <- do.call(rbind, df4)
