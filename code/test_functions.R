library(httr)


url <-  "https://iaspub.epa.gov/"
path <- "enviro/efservice/tri_form_r/rptyear/ 2007/tri_facility/state_abbr/RI/CSV"

raw.result <- GET(url = url, path = path)

content <- rawToChar(raw.result$content)

ri <- read.csv(text = this.raw.content)
