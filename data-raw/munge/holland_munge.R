
####---------------------------------------------------------------------------####

### Holland Munge

head(holland)
tail(holland)

library(tidyverse)
holland %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()   #2019 did only have 232 games


holland_current(Season=2020)  #ok
holland_current(Season=2021)


b <- read.csv("https://www.football-data.co.uk/mmz4281/2122/N1.csv")
b[1:10,1:7] #Cambuur

#use check current teamnames
engsoccerdata::teamnames[grepl("uu", engsoccerdata::teamnames$name),]  #
#SC Cambuur

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Holland",
          name = c("SC Cambuur"),
          name_other = c("Cambuur"),
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

holland_current(Season=2021)

holland_current(Season=2022) #?


b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/N1.csv")
b[1:10,1:7] #Volendam

#use check current teamnames
engsoccerdata::teamnames[grepl("ole", engsoccerdata::teamnames$name),]  #
#FC Volendam

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Holland",
          name = c("FC Volendam"),
          name_other = c("Volendam"),
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

holland_current(Season=2022)
#use check current teamnames



# bind

ex<-
  rbind(
    holland_current(Season=2020),
    holland_current(Season=2021)
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

#update holland.R

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks


###### 2026

h22 <- holland_current(Season = 2022)
h23 <- holland_current(Season = 2023)
h24 <- holland_current(Season = 2024)
h25 <- holland_current(Season = 2025)

c(h22_home_na = sum(is.na(h22$home)), h22_vis_na = sum(is.na(h22$visitor)), n22 = nrow(h22))
c(h23_home_na = sum(is.na(h23$home)), h23_vis_na = sum(is.na(h23$visitor)), n23 = nrow(h23))
c(h24_home_na = sum(is.na(h24$home)), h24_vis_na = sum(is.na(h24$visitor)), n24 = nrow(h24))
c(h25_home_na = sum(is.na(h25$home)), h25_vis_na = sum(is.na(h25$visitor)), n25 = nrow(h25))


get_holland_raw_teams <- function(Season){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1
  n1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/N1.csv"))
  sort(unique(c(as.character(n1$HomeTeam), as.character(n1$AwayTeam))))
}

tm <- engsoccerdata::teamnames

raw22 <- get_holland_raw_teams(2022)
raw23 <- get_holland_raw_teams(2023)

missing_all <- sort(setdiff(unique(c(raw22, raw23)), tm$name_other))
missing_all
length(missing_all)


#use check current teamnames
engsoccerdata::teamnames[grepl("lme", engsoccerdata::teamnames$name),]  #
#FC Volendam

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Holland",
          name = c("Almere City"),
          name_other = c("Almere City"),
          most_recent = NA
        )
  )

head(teamnames)
tail(teamnames)

## update steps
usethis::use_data(teamnames, overwrite = T)
write.csv(teamnames,'data-raw/teamnames.csv',row.names=F)
dim(teamnames)
devtools::document()

h22 <- holland_current(Season = 2022)
h23 <- holland_current(Season = 2023)
h24 <- holland_current(Season = 2024)  # after teamnames fixes

sum(is.na(h22$home)); sum(is.na(h22$visitor))
sum(is.na(h23$home)); sum(is.na(h23$visitor))
sum(is.na(h24$home)); sum(is.na(h24$visitor))

nrow(h22); nrow(h23); nrow(h24)
range(as.Date(h22$Date)); range(as.Date(h23$Date)); range(as.Date(h24$Date))
table(h22$tier)

library(dplyr)

hol_old <- engsoccerdata::holland %>%
  mutate(
    Date = as.Date(Date),
    Season = as.numeric(Season)
  )

hol_new_in <- bind_rows(h22, h23, h24) %>%
  mutate(
    Date = as.Date(Date),
    Season = as.numeric(Season)
  )

hol_merged <- bind_rows(hol_old, hol_new_in) %>%
  distinct(Date, Season, tier, home, visitor, .keep_all = TRUE) %>%
  arrange(Date, tier)

hol_merged$Date <- as.character(hol_merged$Date)

holland <- hol_merged
usethis::use_data(holland, overwrite = TRUE)

write.csv(holland, "data-raw/holland.csv", row.names = FALSE)

# Post-merge QC
max(holland$Season)
holland %>% filter(Season %in% 2022:2024) %>% count(Season, tier)

dup_check <- holland %>%
  count(Date, Season, tier, home, visitor) %>%
  filter(n > 1)
nrow(dup_check)
