
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



####----------------------------------------------------#####
head(belgium)
tail(belgium)

library(tidyverse)
belgium %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

belgium_current(Season=2017)
belgium_current(Season=2018)
belgium_current(Season=2019)

belgium_current(Season=2020)  #one NA  Beerschot   aka  K Beerschot VA

#use check current teamnames

engsoccerdata::teamnames[grepl("eer", engsoccerdata::teamnames$name),]  #  "Beerschot VA"
engsoccerdata::teamnames[grepl("ilr", engsoccerdata::teamnames$name),]  #



# bind

ex<-
  rbind(
    belgium_current(Season=2017),
    belgium_current(Season=2018),
    belgium_current(Season=2019)
  )

belgium <- rbind(belgium,ex)


belgium %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(belgium)

## update steps
usethis::use_data(belgium, overwrite = T)
write.csv(belgium,'data-raw/belgium.csv',row.names=F)
devtools::load_all()

#redoing screwup
df <- read.csv("data-raw/belgium.csv")
tail(df)


load("data/belgium.rda")
tail(belgium)

dim(belgium)

#update current

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks



#####------------------------------------------------------------------------------------#####

head(greece)
tail(greece)

library(tidyverse)
greece %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

greece_current(Season=2017)  #"Lamia"
greece_current(Season=2018)  # "Lamia"     "OFI Crete" (should be OFI)
greece_current(Season=2019)  # "Lamia"     "Volos NFC" "OFI Crete"  (Volos NFC are a new team, not old Volos)

greece_current(Season=2020)  # "OFI Crete" "Lamia"     "Volos NFC"

#use check current teamnames

engsoccerdata::teamnames[grepl("eer", engsoccerdata::teamnames$name),]  #  "Beerschot VA"
engsoccerdata::teamnames[grepl("ilr", engsoccerdata::teamnames$name),]  #


# bind

ex<-
  rbind(
    greece_current(Season=2017),
    greece_current(Season=2018),
    greece_current(Season=2019)
  )

greece <- rbind(greece,ex)

library(tidyverse)
greece %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(greece)

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


####---------------------------------------------------------------------------####


head(holland)
tail(holland)

library(tidyverse)
holland %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

holland_current(Season=2017)  # 2017... date needs fixing.
holland_current(Season=2018)  #"Graafschap"  "For Sittard" "FC Emmen"
holland_current(Season=2019)  # "FC Emmen"    "For Sittard" "Waalwijk"

holland_current(Season=2020)  # "FC Emmen"    "Waalwijk"    "For Sittard"

#use check current teamnames

engsoccerdata::teamnames[grepl("itt", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("aaf", engsoccerdata::teamnames$name),]  #


# bind

ex<-
  rbind(
    holland_current(Season=2017),
    holland_current(Season=2018),
    holland_current(Season=2019)
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

#update current

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks



####---------------------------------------------------------------------------####


head(italy)
tail(italy)

library(tidyverse)
italy %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

italy_current(Season=2017)  #
italy_current(Season=2018)  # "Parma"     "Frosinone"
italy_current(Season=2019)  # "Parma"   "Lecce"   "Brescia"

italy_current(Season=2020)  # "Parma"  "Spezia"

#use check current teamnames

engsoccerdata::teamnames[grepl("arm", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("ecc", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("esci", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("pez", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("rosi", engsoccerdata::teamnames$name),]  #


# bind

ex<-
  rbind(
    italy_current(Season=2017),
    italy_current(Season=2018),
    italy_current(Season=2019)
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

#update current

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks
