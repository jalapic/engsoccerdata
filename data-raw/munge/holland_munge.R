
####---------------------------------------------------------------------------####

### Holland Munge

head(holland)
tail(holland)

library(tidyverse)
holland %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()   #2019 did only have 232 games


holland_current(Season=2020)  #ok
holland_current(Season=2021)


b <- read.csv("https://www.football-data.co.uk/mmz4281/2122/N1.csv")
b[1:10,1:7] #Cambuur

#use check current teamnames
engsoccerdata::teamnames[grepl("uu", engsoccerdata::teamnames$name),]  #
#SC Cambuur

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Holland",
          name = c("SC Cambuur"),
          name_other = c("Cambuur"),
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

holland_current(Season=2021)

holland_current(Season=2022) #?


b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/N1.csv")
b[1:10,1:7] #Volendam

#use check current teamnames
engsoccerdata::teamnames[grepl("ole", engsoccerdata::teamnames$name),]  #
#FC Volendam

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Holland",
          name = c("FC Volendam"),
          name_other = c("Volendam"),
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

holland_current(Season=2022)
#use check current teamnames



# bind

ex<-
  rbind(
    holland_current(Season=2020),
    holland_current(Season=2021)
  )

holland <- rbind(holland,ex)

library(tidyverse)
holland %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(holland)


## update steps
usethis::use_data(holland, overwrite = T)
write.csv(holland,'data-raw/holland.csv',row.names=F)
devtools::load_all()

dim(holland)

#update holland.R

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks


