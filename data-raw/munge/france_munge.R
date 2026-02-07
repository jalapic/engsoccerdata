####----------------------------------------------------#####

# France Munge

head(france)
tail(france)

library(tidyverse)
france %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

france_current(Season=2020) #ok
france_current(Season=2021)


b <- read.csv("https://www.football-data.co.uk/mmz4281/2122/F1.csv")
b[1:12,1:5] #Clermont

#use check current teamnames
engsoccerdata::teamnames[grepl("rmo", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "France",
          name = c("Clermont Foot 63"),
          name_other = c("Clermont"),
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


france_current(Season=2021)





france_current(Season=2022)

b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/F1.csv")
b[1:12,1:5] #Ajaccio   #Auxerre

#use check current teamnames
engsoccerdata::teamnames[grepl("jac", engsoccerdata::teamnames$name),]  #AC Ajaccio
engsoccerdata::teamnames[grepl("ux", engsoccerdata::teamnames$name),]  #AJ Auxerre


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "France",
          name = c("AC Ajaccio","AJ Auxerre"),
          name_other = c("Ajaccio","Auxerre"),
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


france_current(Season=2022)







# bind

ex<-
  rbind(
    france_current(Season=2020),
    france_current(Season=2021)
  )

france <- rbind(france,ex)


france %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(france)

## update steps
usethis::use_data(france, overwrite = T)
write.csv(france,'data-raw/france.csv',row.names=F)
devtools::load_all()

# update france.R
dim(france)

# redo documentation
devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks

head(france)
tail(france)
table(france$Season, france$tier)


## france 2025

library(dplyr)

f22 <- engsoccerdata::france_current(Season = 2022)
f23 <- engsoccerdata::france_current(Season = 2023)
f24 <- engsoccerdata::france_current(Season = 2024)

# QC A: NA names
sum(is.na(f22$home)); sum(is.na(f22$visitor))
sum(is.na(f23$home)); sum(is.na(f23$visitor))
sum(is.na(f24$home)); sum(is.na(f24$visitor))

# QC B: row counts (recent seasons should typically be 380, but don't hardcode)
nrow(f22); nrow(f23); nrow(f24)

# QC C: date ranges
range(as.Date(f22$Date))
range(as.Date(f23$Date))
range(as.Date(f24$Date))

# QC D: tiers/division values
table(f22$tier)
table(f22$division)

# 1) Helper: get raw France team strings from football-data for a season
get_france_raw_teams <- function(Season){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1
  f1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/F1.csv"))
  sort(unique(c(as.character(f1$HomeTeam), as.character(f1$AwayTeam))))
}

# 2) Compare to your mapping table
tm <- engsoccerdata::teamnames

raw22 <- get_france_raw_teams(2022)
raw23 <- get_france_raw_teams(2023)
raw24 <- get_france_raw_teams(2024)

missing22 <- setdiff(raw22, tm$name_other)
missing23 <- setdiff(raw23, tm$name_other)
missing24 <- setdiff(raw24, tm$name_other)

missing22
missing23
missing24

unique(france$home)[grepl("ux", unique(france$home))]
unique(france$home)[grepl("lerm", unique(france$home))]
unique(france$home)[grepl("acc", unique(france$home))]
unique(france$home)[grepl("Ha", unique(france$home))]


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "France",
          name = c("AJ Auxerre","Clermont Foot 63","AC Ajaccio","Le Havre AC"),
          name_other = c("Auxerre", "Clermont","Ajaccio","Le Havre"),
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



f22 <- engsoccerdata::france_current(Season = 2022)
f23 <- engsoccerdata::france_current(Season = 2023)
f24 <- engsoccerdata::france_current(Season = 2024)

# QC A: NA names
sum(is.na(f22$home)); sum(is.na(f22$visitor))
sum(is.na(f23$home)); sum(is.na(f23$visitor))
sum(is.na(f24$home)); sum(is.na(f24$visitor))

# QC B: row counts (recent seasons should typically be 380, but don't hardcode)
nrow(f22); nrow(f23); nrow(f24)

# QC C: date ranges
range(as.Date(f22$Date))
range(as.Date(f23$Date))
range(as.Date(f24$Date))

# QC D: tiers/division values
table(f22$tier)
table(f22$division)


fr_old <- engsoccerdata::france %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

fr_new_in <- bind_rows(f22, f23, f24) %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

fr_merged <- bind_rows(fr_old, fr_new_in) %>%
  distinct(Date, Season, division, tier, home, visitor, .keep_all = TRUE) %>%
  arrange(Date, tier, division)

# store Date as character (your convention)
fr_merged$Date <- as.character(fr_merged$Date)

france <- fr_merged
usethis::use_data(france, overwrite = TRUE)

# optional snapshot
write.csv(france, "data-raw/france.csv", row.names = FALSE)

max(france$Season)

france %>% filter(Season %in% 2022:2024) %>% count(Season, tier)

dup_check <- france %>%
  count(Date, Season, division, tier, home, visitor) %>%
  filter(n > 1)
nrow(dup_check)

head(france$Date)
tail(france$Date)
dim(france)
