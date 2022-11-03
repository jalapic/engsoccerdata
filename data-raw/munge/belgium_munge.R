### Belgium Munge

head(belgium)
tail(belgium)

library(tidyverse)
belgium %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

belgium_current(Season=2019)

belgium_current(Season=2020)  #one NA  Beerschot   aka  K Beerschot VA

b <- belgium_current(Season=2022)
head(b)
tail(b)
head(teamnames)


b1<- read.csv(paste0("https://www.football-data.co.uk/mmz4281/",s2,s1,"/B1.csv"))
head(b1$HomeTeam)

unique(b1$HomeTeam)[!unique(b1$HomeTeam) %in% teamnames$name_other]
#"St. Gilloise"
# aka Royal Union Saint-Gilloise
# have they appeared in the data before?
teamnames[grepl("ill",teamnames$name),]  #
teamnames[grepl("ill",teamnames$name_other),]  #
teamnames[grepl("nion",teamnames$name_other),]  #
teamnames[grepl("USG",teamnames$name_other),]  #
unique(teamnames$country)

teamnames %>% filter(country=="Belgium")

# date range Belgium
head(belgium) # begins in 1995

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Belgium",
          name = c("Royal Union Saint-Gilloise"),
          name_other = c("St. Gilloise"),
          most_recent = NA
        )
  )

head(teamnames)
tail(teamnames)
teamnames$country <- gsub("spain", "Spain", teamnames$country)


## update steps
usethis::use_data(teamnames, overwrite = T)
write.csv(teamnames,'data-raw/teamnames.csv',row.names=F)
# redo documentation   devtools::document()





#use check current teamnames

engsoccerdata::teamnames[grepl("eer", engsoccerdata::teamnames$name),]  #  "Beerschot VA"
engsoccerdata::teamnames[grepl("ilr", engsoccerdata::teamnames$name),]  #


# check other seasons for teamnames

b1<- read.csv(paste0("https://www.football-data.co.uk/mmz4281/2122/B1.csv"))
b1<- read.csv(paste0("https://www.football-data.co.uk/mmz4281/2021/B1.csv"))
b1<- read.csv(paste0("https://www.football-data.co.uk/mmz4281/1920/B1.csv"))

unique(b1$HomeTeam)[!unique(b1$HomeTeam) %in% teamnames$name_other]


#### Combine 2019-20; 2020-21;


belgium_current(Season = 2022)

# bind

ex<-
  rbind(
    belgium_current(Season=2019),
    belgium_current(Season=2020),
    belgium_current(Season=2021)
  )


# remove belgium 2019 already got

belgium <- rbind(belgium[belgium$Season!=2019,],ex)

# check number of games.
belgium %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(belgium)

engsoccerdata::maketable_all(belgium[belgium$Season==2021,])

## update steps
usethis::use_data(belgium, overwrite = T)
write.csv(belgium,'data-raw/belgium.csv',row.names=F)
devtools::load_all()

#redoing screwup
df <- read.csv("data-raw/belgium.csv")
tail(df)

#Belgium playoffs...

#update belgium.R
dim(belgium)

#load("data/belgium.rda")
tail(belgium)

dim(belgium)

#update current

# redo documentation   devtools::document()
devtools::document()
devtools::load_all()


#rebuild
#redo checks
