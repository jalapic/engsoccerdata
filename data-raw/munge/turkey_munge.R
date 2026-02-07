# Turkey munge

head(turkey)
tail(turkey)

library(tidyverse)
turkey %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()


turkey_current(Season=2020)  #
turkey_current(Season=2021)  #  "Giresunspor"

# identify missing team
b <- read.csv("https://www.football-data.co.uk/mmz4281/2122/T1.csv")
b[1:10,1:5] #Giresunspor

#check if teamname already existed somehow
engsoccerdata::teamnames[grepl("unsp", engsoccerdata::teamnames$name),]  #

# bind into teamnames.csv

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Turkey",
          name = c("Giresunspor"),
          name_other = c("Giresunspor"),
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



turkey_current(Season=2022)  #  Umraniyespor


# identify missing team
b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/T1.csv")
b[1:10,1:5] #Umraniyespor

#check if teamname already existed somehow
engsoccerdata::teamnames[grepl("mra", engsoccerdata::teamnames$name),]  #

# bind into teamnames.csv

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Turkey",
          name = c("Umraniyespor"),
          name_other = c("Umraniyespor"),
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


## check now working ok
turkey_current(Season = 2021)
turkey_current(Season = 2022)


## Add in new data
tail(turkey)

ex<-
  rbind(
    turkey_current(Season=2020),
    turkey_current(Season=2021)
  )

turkey <- rbind(turkey,ex)

#checks - should be 0 rows
turkey[is.na(turkey$home),]
turkey[is.na(turkey$visitor),]


library(tidyverse)
turkey %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(turkey)


## update steps
usethis::use_data(turkey, overwrite = T)
write.csv(turkey,'data-raw/turkey.csv',row.names=F)
devtools::load_all()

dim(turkey) #update turkey.R


# redo documentation
devtools::document()
devtools::load_all()
devtools::document()

#rebuild
#redo checks

#####
tail(turkey)
turkey

get_turkey_raw_teams <- function(Season){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1
  t1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/T1.csv"))
  sort(unique(c(as.character(t1$HomeTeam), as.character(t1$AwayTeam))))
}

tm <- engsoccerdata::teamnames

raw22 <- get_turkey_raw_teams(2022)
raw23 <- get_turkey_raw_teams(2023)
raw24 <- get_turkey_raw_teams(2024)
raw25 <- get_turkey_raw_teams(2025)

missing_all <- sort(setdiff(unique(c(raw22, raw23,raw24,raw25)), tm$name_other))
missing_all
length(missing_all)

# "Eyupspor"   "Pendikspor"

#check if teamname already existed somehow
engsoccerdata::teamnames[grepl("yup", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("iks", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("rum", engsoccerdata::teamnames$name),]  #

# bind into teamnames.csv

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Turkey",
          name = c("Eyupspor","Pendikspor","Bodrumspor"),
          name_other = c("Eyupspor","Pendikspor","Bodrumspor"),
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

t22 <- turkey_current(Season = 2022)
t23 <- turkey_current(Season = 2023)
t24 <- turkey_current(Season = 2024)

sum(is.na(t22$home)); sum(is.na(t22$visitor))
sum(is.na(t23$home)); sum(is.na(t23$visitor))
sum(is.na(t24$home)); sum(is.na(t24$visitor))

nrow(t22); nrow(t23); nrow(t24)
range(as.Date(t22$Date)); range(as.Date(t23$Date)); range(as.Date(t24$Date))



library(dplyr)

tur_old <- engsoccerdata::turkey %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

tur_new_in <- bind_rows(t22, t23, t24) %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

tur_merged <- bind_rows(tur_old, tur_new_in) %>%
  distinct(Date, Season, division, tier, home, visitor, .keep_all = TRUE) %>%
  arrange(Date, tier, division)

tur_merged$Date <- as.character(tur_merged$Date)

turkey <- tur_merged
usethis::use_data(turkey, overwrite = TRUE)
write.csv(turkey, "data-raw/turkey.csv", row.names = FALSE)

# post-merge QC
max(turkey$Season)
turkey %>% filter(Season %in% 2022:2024) %>% count(Season, tier)

nrow(turkey %>%
       count(Date, Season, division, tier, home, visitor) %>%
       filter(n > 1))

