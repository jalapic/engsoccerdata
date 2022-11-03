### Portugal Munge

head(portugal)
tail(portugal)

library(tidyverse)
portugal %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

portugal_current(Season=2020) #ok
portugal_current(Season=2021)

b <- read.csv("https://www.football-data.co.uk/mmz4281/2122/P1.csv")
b[1:10,1:5] #Vizela

#use check current teamnames
engsoccerdata::teamnames[grepl("iz", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Portugal",
          name = c("FC Vizela"),
          name_other = c("Vizela"),
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


portugal_current(Season=2022)

b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/P1.csv")
b[1:10,1:5] #Casa Pia

#use check current teamnames
engsoccerdata::teamnames[grepl("asa", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Portugal",
          name = c("Casa Pia AC"),
          name_other = c("Casa Pia"),
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






# bind
library(tidyverse)
portugal %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

ex<-
  rbind(
    portugal_current(Season=2020),
    portugal_current(Season=2021)
  )

portugal <- rbind(portugal,ex)

library(tidyverse)
portugal %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(portugal)


#checks - should be 0 rows
portugal[is.na(portugal$home),]
portugal[is.na(portugal$visitor),]





## update steps
usethis::use_data(portugal, overwrite = T)
write.csv(portugal,'data-raw/portugal.csv',row.names=F)
devtools::load_all()

dim(portugal)

#update portugal.R

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks
