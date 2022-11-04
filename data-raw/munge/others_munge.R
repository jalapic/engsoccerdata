


####----------------------------------------------------#####






####---------------------------------------------------------------------------####


####---------------------------------------------------------------------------####


head(scotland)
tail(scotland)

library(tidyverse)
scotland %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

s01 = scotland_current(Season=2017)  #
s01
s01[is.na(s01$home),]

s01 = scotland_current(Season=2018)  #
s01
s01[is.na(s01$home),]

s01 = scotland_current(Season=2019)  #
s01
s01[is.na(s01$home),]
s01[is.na(s01$visitor),]

s01 = scotland_current(Season=2020)  #
s01
s01[is.na(s01$home),]
s01[is.na(s01$visitor),]


#use check current teamnames

engsoccerdata::teamnames[grepl("ama", engsoccerdata::teamnames$name),]  #


# bind

ex<-
  rbind(
    scotland_current(Season=2017),
    scotland_current(Season=2018),
    scotland_current(Season=2019)
  )

scotland <- rbind(scotland,ex)

library(tidyverse)
scotland %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count() %>%
  as.data.frame()

tail(scotland)


## update steps
usethis::use_data(scotland, overwrite = T)
write.csv(scotland,'data-raw/scotland.csv',row.names=F)
devtools::load_all()

dim(scotland)

#update current

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks




