
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

