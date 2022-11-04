
## Germany munge


library(tidyverse)

tail(germany)

germany %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()


tst <- germany_current(Season=2020)
tst[is.na(tst$home),]

tst <- germany_current(Season=2021)
tst[is.na(tst$home),]

tst <- germany_current(Season=2022)
tst[is.na(tst$home),]
tst %>% filter(tier==2)

g1=read.csv("https://www.football-data.co.uk/mmz4281/2021/D1.csv")
g2=read.csv("https://www.football-data.co.uk/mmz4281/2021/D2.csv")



ex<-
  rbind(
    germany_current(Season=2020),
    germany_current(Season=2021)
  )

head(ex)
tail(ex, 50)

ex[is.na(ex$home),]


teams <- unique(c(as.character(ex$home),as.character(ex$visitor)))
teams %in% teamnames$name



# bind
germany <- rbind(germany,ex)

germany %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()


## update steps
usethis::use_data(germany, overwrite = T)
write.csv(germany,'data-raw/germany.csv',row.names=F)
devtools::load_all()

dim(germany)
#update germany.R


# redo documentation   devtools::document()
devtools::load_all()

devtools::document()


# rebuild
# redo checks

