####----------------------------------------------------#####

# France Munge

head(france)
tail(france)

library(tidyverse)
france %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

france_current(Season=2020) #ok
france_current(Season=2021)


b <- read.csv("https://www.football-data.co.uk/mmz4281/2122/F1.csv")
b[1:12,1:5] #Clermont

#use check current teamnames
engsoccerdata::teamnames[grepl("rmo", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "France",
          name = c("Clermont Foot 63"),
          name_other = c("Clermont"),
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


france_current(Season=2021)





france_current(Season=2022)

b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/F1.csv")
b[1:12,1:5] #Ajaccio   #Auxerre

#use check current teamnames
engsoccerdata::teamnames[grepl("jac", engsoccerdata::teamnames$name),]  #AC Ajaccio
engsoccerdata::teamnames[grepl("ux", engsoccerdata::teamnames$name),]  #AJ Auxerre


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "France",
          name = c("AC Ajaccio","AJ Auxerre"),
          name_other = c("Ajaccio","Auxerre"),
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


france_current(Season=2022)







# bind

ex<-
  rbind(
    france_current(Season=2020),
    france_current(Season=2021)
  )

france <- rbind(france,ex)


france %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(france)

## update steps
usethis::use_data(france, overwrite = T)
write.csv(france,'data-raw/france.csv',row.names=F)
devtools::load_all()

# update france.R
dim(france)

# redo documentation
devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks

