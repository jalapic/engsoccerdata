#####------------------------------------------------------------------------------------#####

head(greece)
tail(greece)

#check where we are at
greece %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

#looks like ok up to end of 2019/20 season.


#why only 305 games in 2014/15 ?
maketable_all(greece %>% filter(Season==2014))
# missing a game between OFI and Niki Volos.
# this whole season was a disaster.
# but the data are correct in the results db
# although contains numerous 3-0 walkovers

greece %>% filter(Season==2014) %>% filter(
  home=="Niki Volos"|visitor=="Niki Volos")


library(tidyverse)
greece %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

# identify teamnames not include
greece_current(Season=2020)  # ok
greece_current(Season=2021)  # ok
greece_current(Season=2022)  # ok


#use check current teamnames

engsoccerdata::teamnames[grepl("eer", engsoccerdata::teamnames$name),]  #  "Beerschot VA"
engsoccerdata::teamnames[grepl("ilr", engsoccerdata::teamnames$name),]  #


# bind

ex<-
  rbind(
    greece_current(Season=2020),
    greece_current(Season=2021)
  )

greece <- rbind(greece,ex)


# weird NA for visitor 2022-05-15

#            Date Season             home visitor  FT hgoal vgoal division tier totgoal goaldif result
# 7184 2022-05-15   2021 Asteras Tripolis    <NA> 2-2     2     2       G1    1       4       0      D

tail(greece_current(Season=2021)) # in original downloaded file.

x <- greece_current(Season=2021)
table(c(x$home,x$visitor))
maketable_all(x)  #they play different numbers of games!!!!


# includes playoff games....  Need to fix ultimately.



library(tidyverse)
greece %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()


tail(greece)

# fix missing team name
greece[7184,4]<-"Apollon"

## update steps
usethis::use_data(greece, overwrite = T)
write.csv(greece,'data-raw/greece.csv',row.names=F)
devtools::load_all()

dim(greece)

#update current

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks
