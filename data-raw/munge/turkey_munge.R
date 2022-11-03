# Turkey munge

head(turkey)
tail(turkey)

library(tidyverse)
turkey %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()


turkey_current(Season=2020)  #
turkey_current(Season=2021)  #  "Giresunspor"

# identify missing team
b <- read.csv("https://www.football-data.co.uk/mmz4281/2122/T1.csv")
b[1:10,1:5] #Giresunspor

#check if teamname already existed somehow
engsoccerdata::teamnames[grepl("unsp", engsoccerdata::teamnames$name),]  #

# bind into teamnames.csv

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Turkey",
          name = c("Giresunspor"),
          name_other = c("Giresunspor"),
          most_recent = NA
        )
  )

head(teamnames)
tail(teamnames)

## update steps
usethis::use_data(teamnames, overwrite = T)
write.csv(teamnames,'data-raw/teamnames.csv',row.names=F)
# redo documentation
devtools::document()



turkey_current(Season=2022)  #  Umraniyespor


# identify missing team
b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/T1.csv")
b[1:10,1:5] #Umraniyespor

#check if teamname already existed somehow
engsoccerdata::teamnames[grepl("mra", engsoccerdata::teamnames$name),]  #

# bind into teamnames.csv

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Turkey",
          name = c("Umraniyespor"),
          name_other = c("Umraniyespor"),
          most_recent = NA
        )
  )

head(teamnames)
tail(teamnames)

## update steps
usethis::use_data(teamnames, overwrite = T)
write.csv(teamnames,'data-raw/teamnames.csv',row.names=F)
# redo documentation
devtools::document()


## check now working ok
turkey_current(Season = 2021)
turkey_current(Season = 2022)


## Add in new data
tail(turkey)

ex<-
  rbind(
    turkey_current(Season=2020),
    turkey_current(Season=2021)
  )

turkey <- rbind(turkey,ex)

#checks - should be 0 rows
turkey[is.na(turkey$home),]
turkey[is.na(turkey$visitor),]


library(tidyverse)
turkey %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(turkey)


## update steps
usethis::use_data(turkey, overwrite = T)
write.csv(turkey,'data-raw/turkey.csv',row.names=F)
devtools::load_all()

dim(turkey) #update turkey.R


# redo documentation
devtools::document()
devtools::load_all()
devtools::document()

#rebuild
#redo checks

