engsoccerdata2 <- read.csv("data-raw/engsoccerdata2.csv",
                           stringsAsFactors = FALSE)
engsoccerteams <- read.csv("data-raw/engsoccerteams.csv",
                           stringsAsFactors = FALSE)
facup <- read.csv("data-raw/facup.csv",
                  stringsAsFactors = FALSE)
facupteams <- read.csv("data-raw/facupteams.csv",
                       stringsAsFactors = FALSE)
playoffs <- read.csv("data-raw/playoffs.csv",
                       stringsAsFactors = FALSE)
devtools::use_data(engsoccerdata2, engsoccerteams, facup, facupteams, playoffs, overwrite = TRUE)
