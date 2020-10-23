
## Germany munge


library(tidyverse)

tail(germany)

germany %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

germany_current(Season=2017)
germany_current(Season=2018)
germany_current(Season=2019)
germany_current(Season=2020)


ex<-
rbind(
  germany_current(Season=2017),
  germany_current(Season=2018),
  germany_current(Season=2019)
)

head(ex)
tail(ex, 50)

ex[is.na(ex$home),]
ex[grepl("agd", ex$home),]

tail(teamnames)

teams <- unique(c(as.character(ex$home),as.character(ex$visitor)))

teams

# 1. FC Magdeburg
# SC Paderborn

teamnames[grepl("bur", teamnames$name),]
teamnames[grepl("ader", teamnames$name),]

teams %in% teamnames$name

head(teamnames)
teamnames$name


germany_current(Season=2018) %>% filter(tier==2)


# bind
germany <- rbind(germany,ex)

germany %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(germany)

## update steps
usethis::use_data(germany, overwrite = T)
write.csv(germany,'data-raw/germany.csv',row.names=F)
devtools::load_all()



# redo documentation   devtools::document()
devtools::load_all()

devtools::document()


# rebuild
# redo checks




####----------------------------------------------------#####
head(france)
tail(france)

library(tidyverse)
france %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

france_current(Season=2017)
france_current(Season=2018)  #one NA             "Nimes"
france_current(Season=2019)   # possibly two NA    "Brest" "Nimes"
france_current(Season=2020)  # possibly two NA   "Nimes" "Brest" "Lens"

#use check current teamnames

engsoccerdata::teamnames[grepl("ime", engsoccerdata::teamnames$name),]  #Nimes Olympique
engsoccerdata::teamnames[grepl("rest", engsoccerdata::teamnames$name),] #Stade Brest
engsoccerdata::teamnames[grepl("ens", engsoccerdata::teamnames$name),] #RC Lens






# bind

ex<-
  rbind(
    france_current(Season=2017),
    france_current(Season=2018),
    france_current(Season=2019)
  )

france <- rbind(france,ex)


france %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(france)

## update steps
usethis::use_data(france, overwrite = T)
write.csv(germany,'data-raw/france.csv',row.names=F)
devtools::load_all()



# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks
