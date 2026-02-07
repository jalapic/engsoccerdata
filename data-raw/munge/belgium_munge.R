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



#### 2026 update

head(belgium)
tail(belgium)
table(belgium$Season,belgium$tier)


get_belgium_raw_teams <- function(Season){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1
  b1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/B1.csv"))
  sort(unique(c(as.character(b1$HomeTeam), as.character(b1$AwayTeam))))
}

tm <- engsoccerdata::teamnames

raw22 <- get_belgium_raw_teams(2022)
raw23 <- get_belgium_raw_teams(2023)
raw24 <- get_belgium_raw_teams(2024)
raw25 <- get_belgium_raw_teams(2025)

missing_all <- sort(setdiff(unique(c(raw22, raw23, raw24, raw25)), tm$name_other))
missing_all
length(missing_all)

# "RAAL La Louviere" "RWD Molenbeek"

teamnames[grepl("olen",teamnames$name_other),]  #
teamnames[grepl("ouv",teamnames$name_other),]  #

teamnames %>% filter(country=="Belgium")

belgium %>% filter(home=="Molenbeek")

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Belgium",
          name = c("Molenbeek", "RAAL La Louviere"),
          name_other = c("RWD Molenbeek","RAAL La Louviere"),
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


b22 <- belgium_current(Season = 2022)
b23 <- belgium_current(Season = 2023)
b24 <- belgium_current(Season = 2024)

# QC NAs
sum(is.na(b22$home)); sum(is.na(b22$visitor))
sum(is.na(b23$home)); sum(is.na(b23$visitor))
sum(is.na(b24$home)); sum(is.na(b24$visitor))

# QC rows / dates
nrow(b22); nrow(b23); nrow(b24)
range(as.Date(b22$Date)); range(as.Date(b23$Date)); range(as.Date(b24$Date))

b23 %>%
  count(home, visitor, sort = TRUE) %>%
  filter(n > 1)

b24 %>%
  count(home, visitor, sort = TRUE) %>%
  filter(n > 1)

write.csv(b23, "data-raw/belgium_current_2023_raw.csv", row.names = FALSE)
write.csv(b24, "data-raw/belgium_current_2024_raw.csv", row.names = FALSE)


library(dplyr)

bel_old <- engsoccerdata::belgium %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

bel_new_in <- bind_rows(b22, b23, b24) %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

bel_merged <- bind_rows(bel_old, bel_new_in) %>%
  distinct(Date, Season, division, tier, home, visitor, .keep_all = TRUE) %>%
  arrange(Date, tier, division)

bel_merged$Date <- as.character(bel_merged$Date)

belgium <- bel_merged
usethis::use_data(belgium, overwrite = TRUE)
write.csv(belgium, "data-raw/belgium.csv", row.names = FALSE)

# Post-merge QC
max(belgium$Season)
belgium %>% filter(Season %in% 2022:2024) %>% count(Season, tier)

dup_check <- belgium %>%
  count(Date, Season, division, tier, home, visitor) %>%
  filter(n > 1)
nrow(dup_check)

b25 <- belgium_current(Season = 2025)
sum(is.na(b25$home)); sum(is.na(b25$visitor))
