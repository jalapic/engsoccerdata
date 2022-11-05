
####---------------------------------------------------------------------------####

### Scotland Munge

head(scotland)
tail(scotland)

library(tidyverse)
scotland %>%
  filter(Season>2016) %>%
  group_by(tier,Season) %>%
  count()

s01 = scotland_current(Season=2020)  #
s01
s01[is.na(s01$home),]

s01 = scotland_current(Season=2021)  #
s01
s01[is.na(s01$home),]
s01[is.na(s01$visitor),]

ss4=read.csv("https://www.football-data.co.uk/mmz4281/2122/SC3.csv")
ss4



#use check current teamnames
engsoccerdata::teamnames[grepl("elt", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Scotland",
          name = c("Kelty Hearts"),
          name_other = c("Kelty Hearts"),
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


s01 = scotland_current(Season=2021)  #
s01
s01[is.na(s01$home),]

s01 = scotland_current(Season=2022)  #
s01
s01[is.na(s01$home),]
s01[is.na(s01$visitor),]



#use check current teamnames

ss4=read.csv("https://www.football-data.co.uk/mmz4281/2223/SC3.csv")
ss4

ss3=read.csv("https://www.football-data.co.uk/mmz4281/2223/SC2.csv")
ss3


#Bonnyrigg Rose
#FC Edinburgh
engsoccerdata::teamnames[grepl("urgh", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("igg", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Scotland",
          name = c("Edinburgh City", "Bonnyrigg Rose Athletic"),
          name_other = c("FC Edinburgh", "Bonnyrigg Rose"),
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

ex<-
  rbind(
    scotland_current(Season=2020),
    scotland_current(Season=2021)
  )

scotland <- rbind(scotland,ex)

library(tidyverse)
scotland %>%
  filter(Season>2017) %>%
  group_by(tier,Season) %>%
  count() %>%
  as.data.frame()

tail(scotland)


## update steps
usethis::use_data(scotland, overwrite = T)
write.csv(scotland,'data-raw/scotland.csv',row.names=F)
devtools::load_all()

dim(scotland)
#update scotland.R

#update current

# redo documentation
devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks




