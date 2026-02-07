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


#### 2026

tail(greece)

get_greece_raw_teams <- function(Season){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1
  g1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/G1.csv"))
  sort(unique(c(as.character(g1$HomeTeam), as.character(g1$AwayTeam))))
}

tm <- engsoccerdata::teamnames

raw22 <- get_greece_raw_teams(2022)
raw23 <- get_greece_raw_teams(2023)
raw24 <- get_greece_raw_teams(2024)
raw25 <- get_greece_raw_teams(2025)

missing_all <- sort(setdiff(unique(c(raw22, raw23,raw24,raw25)), tm$name_other))
missing_all
length(missing_all)

# "Athens Kallithea" "Kifisia"

engsoccerdata::teamnames[grepl("lli", engsoccerdata::teamnames$name),]  #  "Beerschot VA"
engsoccerdata::teamnames[grepl("ifi", engsoccerdata::teamnames$name),]  #



# bind into teamnames.csv

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Greece",
          name = c("Kifisia","Kallithea"),
          name_other = c("Kifisia","Athens Kallithea"),
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


g22 <- greece_current(Season = 2022)
g23 <- greece_current(Season = 2023)
g24 <- greece_current(Season = 2024)

sum(is.na(g22$home)); sum(is.na(g22$visitor))
sum(is.na(g23$home)); sum(is.na(g23$visitor))
sum(is.na(g24$home)); sum(is.na(g24$visitor))

nrow(g22); nrow(g23); nrow(g24)
range(as.Date(g22$Date)); range(as.Date(g23$Date)); range(as.Date(g24$Date))

table(g22$tier)
table(g22$division)


library(dplyr)

gr_old <- engsoccerdata::greece %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

gr_new_in <- bind_rows(g22, g23, g24) %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

gr_merged <- bind_rows(gr_old, gr_new_in) %>%
  distinct(Date, Season, division, tier, home, visitor, .keep_all = TRUE) %>%
  arrange(Date, tier, division)

gr_merged$Date <- as.character(gr_merged$Date)

greece <- gr_merged
usethis::use_data(greece, overwrite = TRUE)
write.csv(greece, "data-raw/greece.csv", row.names = FALSE)

# post-merge QC
max(greece$Season)
greece %>% filter(Season %in% 2022:2024) %>% count(Season, tier)

nrow(greece %>%
       count(Date, Season, division, tier, home, visitor) %>%
       filter(n > 1))



### checking 2024 season

get_greece_raw <- function(Season){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1
  read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/G1.csv"))
}

raw_g24 <- get_greece_raw(2024)
nrow(raw_g24)
sum(is.na(raw_g24$HomeTeam)); sum(is.na(raw_g24$AwayTeam))
sum(is.na(raw_g24$FTHG)); sum(is.na(raw_g24$FTAG))
tail(raw_g24[, c("Date","HomeTeam","AwayTeam","FTHG","FTAG","FTR")], 20)

sort(table(c(g24$home, g24$visitor)))

