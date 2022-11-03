####---------------------------------------------------------------------------####

### Spain Munge


head(spain)
tail(spain)

library(tidyverse)
spain %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

# only tier 1 data.

# check teams.


spain_current(Season=2020)  #
spain_current(Season=2021)  #
spain_current(Season=2022)


b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/SP1.csv")
b[1:10,1:7] #Almeria

#use check current teamnames
engsoccerdata::teamnames[grepl("mer", engsoccerdata::teamnames$name),]  #
#UD Almeria

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Spain",
          name = c("UD Almeria"),
          name_other = c("Almeria"),
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


spain_current(Season=2022)



# bind

library(tidyverse)
spain %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

ex<-
  rbind(
    spain_current(Season=2020),
    spain_current(Season=2021)
  )

spain <- rbind(spain,ex)

library(tidyverse)
spain %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(spain)


## update steps
usethis::use_data(spain, overwrite = T)
write.csv(spain,'data-raw/spain.csv',row.names=F)
devtools::load_all()

dim(spain)

#update spain.R

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks





####---------------------------------------------------------------------------####
