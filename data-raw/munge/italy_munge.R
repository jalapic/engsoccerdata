### Italy Munge

####---------------------------------------------------------------------------####

i1=read.csv("https://www.football-data.co.uk/mmz4281/2021/I1.csv")

head(italy)
tail(italy)

library(tidyverse)
italy %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

table(italy$Season,italy$tier)

italy_current(Season=2020)  #

italy_current(Season=2021)  #


b <- read.csv("https://www.football-data.co.uk/mmz4281/2122/I1.csv")

b[1:10,1:5] #Salernitana;   Venezia

#use check current teamnames
engsoccerdata::teamnames[grepl("ern", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("enez", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Italy",
          name = c("Salernitana Calcio 1919", "AC Venezia"),
          name_other = c("Salernitana","Venezia"),
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

italy_current(Season=2021)  #



italy_current(Season=2022)  #

b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/I1.csv")

b[1:10,1:5] #Monza;   Cremonese

#use check current teamnames
engsoccerdata::teamnames[grepl("onz", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("remo", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Italy",
          name = c("AC Monza", "US Cremonese"),
          name_other = c("Monza","Cremonese"),
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

italy_current(Season=2022)  #


#use check current teamnames



# bind

italy %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()


ex<-
  rbind(
    italy_current(Season=2020),
    italy_current(Season=2021)
  )

italy <- rbind(italy,ex)

library(tidyverse)
italy %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(italy)


## update steps
usethis::use_data(italy, overwrite = T)
write.csv(italy,'data-raw/italy.csv',row.names=F)
devtools::load_all()

dim(italy)

#update italy.R

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks



