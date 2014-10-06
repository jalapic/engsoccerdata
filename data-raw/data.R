engsoccerdata2 <- read.csv("data-raw/engsoccerdata2.csv",
                           stringsAsFactors = FALSE)
engsoccerteams <- read.csv("data-raw/engsoccerteams.csv",
                           stringsAsFactors = FALSE)
devtools::use_data(engsoccerdata2, engsoccerteams, overwrite = TRUE)
