### Portugal Munge

head(portugal)
tail(portugal)

library(tidyverse)
portugal %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

portugal_current(Season=2020) #ok
portugal_current(Season=2021)

b <- read.csv("https://www.football-data.co.uk/mmz4281/2122/P1.csv")
b[1:10,1:5] #Vizela

#use check current teamnames
engsoccerdata::teamnames[grepl("iz", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Portugal",
          name = c("FC Vizela"),
          name_other = c("Vizela"),
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


portugal_current(Season=2022)

b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/P1.csv")
b[1:10,1:5] #Casa Pia

#use check current teamnames
engsoccerdata::teamnames[grepl("asa", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Portugal",
          name = c("Casa Pia AC"),
          name_other = c("Casa Pia"),
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






# bind
library(tidyverse)
portugal %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

ex<-
  rbind(
    portugal_current(Season=2020),
    portugal_current(Season=2021)
  )

portugal <- rbind(portugal,ex)

library(tidyverse)
portugal %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(portugal)


#checks - should be 0 rows
portugal[is.na(portugal$home),]
portugal[is.na(portugal$visitor),]





## update steps
usethis::use_data(portugal, overwrite = T)
write.csv(portugal,'data-raw/portugal.csv',row.names=F)
devtools::load_all()

dim(portugal)

#update portugal.R

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks


##### 2026

head(portugal)
tail(portugal)
table(portugal$Season,portugal$tier)


p22 <- portugal_current(Season = 2022)
p23 <- portugal_current(Season = 2023)
p24 <- portugal_current(Season = 2024)
p25 <- portugal_current(Season = 2025)

c(p22_home_na = sum(is.na(p22$home)), p22_vis_na = sum(is.na(p22$visitor)), n22 = nrow(p22))
c(p23_home_na = sum(is.na(p23$home)), p23_vis_na = sum(is.na(p23$visitor)), n23 = nrow(p23))
c(p24_home_na = sum(is.na(p24$home)), p24_vis_na = sum(is.na(p24$visitor)), n24 = nrow(p24))
c(p25_home_na = sum(is.na(p25$home)), p25_vis_na = sum(is.na(p25$visitor)), n25 = nrow(p25))


get_portugal_raw_teams <- function(Season){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1
  p1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/P1.csv"))
  sort(unique(c(as.character(p1$HomeTeam), as.character(p1$AwayTeam))))
}

tm <- engsoccerdata::teamnames
raw22 <- get_portugal_raw_teams(2022)
raw23 <- get_portugal_raw_teams(2023)
raw24 <- get_portugal_raw_teams(2024)
raw25 <- get_portugal_raw_teams(2025)

missing_all <- sort(unique(c(
  setdiff(raw22, tm$name_other),
  setdiff(raw23, tm$name_other),
  setdiff(raw24, tm$name_other),
  setdiff(raw25, tm$name_other)
)))
missing_all
length(missing_all)


#use check current teamnames
engsoccerdata::teamnames[grepl("tre", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("AVS", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Portugal",
          name = c("Estrela da Amadora", "AVS Futebol SAD"),
          name_other = c("Estrela", "AVS"),
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

p22 <- portugal_current(Season = 2022)
p23 <- portugal_current(Season = 2023)
p24 <- portugal_current(Season = 2024)  # after fixes

# QC
sum(is.na(p22$home)); sum(is.na(p22$visitor))
sum(is.na(p23$home)); sum(is.na(p23$visitor))
sum(is.na(p24$home)); sum(is.na(p24$visitor))
nrow(p22); nrow(p23); nrow(p24)
range(as.Date(p22$Date)); range(as.Date(p23$Date)); range(as.Date(p24$Date))

library(dplyr)

pt_old <- engsoccerdata::portugal %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

pt_new_in <- bind_rows(p22, p23, p24) %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

pt_merged <- bind_rows(pt_old, pt_new_in) %>%
  distinct(Date, Season, division, tier, home, visitor, .keep_all = TRUE) %>%
  arrange(Date, tier, division)

pt_merged$Date <- as.character(pt_merged$Date)

portugal <- pt_merged
usethis::use_data(portugal, overwrite = TRUE)

write.csv(portugal, "data-raw/portugal.csv", row.names = FALSE)

# Post-merge QC
max(portugal$Season)
portugal %>% filter(Season %in% 2022:2024) %>% count(Season, tier)

nrow(portugal %>%
       count(Date, Season, division, tier, home, visitor) %>%
       filter(n > 1))
