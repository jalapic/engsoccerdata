
####---------------------------------------------------------------------------####

### Scotland Munge

head(scotland)
tail(scotland)

library(tidyverse)
scotland %>%
  filter(Season>2016) %>%
  group_by(tier,Season) %>%
  count()

s01 = scotland_current(Season=2020)  #
s01
s01[is.na(s01$home),]

s01 = scotland_current(Season=2021)  #
s01
s01[is.na(s01$home),]
s01[is.na(s01$visitor),]

ss4=read.csv("https://www.football-data.co.uk/mmz4281/2122/SC3.csv")
ss4



#use check current teamnames
engsoccerdata::teamnames[grepl("elt", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Scotland",
          name = c("Kelty Hearts"),
          name_other = c("Kelty Hearts"),
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


s01 = scotland_current(Season=2021)  #
s01
s01[is.na(s01$home),]

s01 = scotland_current(Season=2022)  #
s01
s01[is.na(s01$home),]
s01[is.na(s01$visitor),]



#use check current teamnames

ss4=read.csv("https://www.football-data.co.uk/mmz4281/2223/SC3.csv")
ss4

ss3=read.csv("https://www.football-data.co.uk/mmz4281/2223/SC2.csv")
ss3


#Bonnyrigg Rose
#FC Edinburgh
engsoccerdata::teamnames[grepl("urgh", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("igg", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Scotland",
          name = c("Edinburgh City", "Bonnyrigg Rose Athletic"),
          name_other = c("FC Edinburgh", "Bonnyrigg Rose"),
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

ex<-
  rbind(
    scotland_current(Season=2020),
    scotland_current(Season=2021)
  )

scotland <- rbind(scotland,ex)

library(tidyverse)
scotland %>%
  filter(Season>2017) %>%
  group_by(tier,Season) %>%
  count() %>%
  as.data.frame()

tail(scotland)


## update steps
usethis::use_data(scotland, overwrite = T)
write.csv(scotland,'data-raw/scotland.csv',row.names=F)
devtools::load_all()

dim(scotland)
#update scotland.R

#update current

# redo documentation
devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks


###### 2026 update

library(dplyr)

seasons_to_add <- 2022:2024

sco_list <- lapply(seasons_to_add, function(s) engsoccerdata::scotland_current(Season = s))
names(sco_list) <- as.character(seasons_to_add)

# QC A: name mapping (should be all zeros)
na_qc <- sapply(sco_list, function(df) c(home_na = sum(is.na(df$home)), visitor_na = sum(is.na(df$visitor))))
t(na_qc)




# QC B: row counts + tier counts
rows_qc <- sapply(sco_list, nrow)
rows_qc

tier_qc <- lapply(sco_list, function(df) table(df$tier))
tier_qc

# QC C: date ranges
date_qc <- lapply(sco_list, function(df) range(as.Date(df$Date)))
date_qc



# Pull raw Scotland team names directly from football-data (no mapping)
get_scotland_raw_teams <- function(Season){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1

  sc0 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/SC0.csv"))
  sc1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/SC1.csv"))
  sc2 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/SC2.csv"))
  sc3 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/SC3.csv"))

  sort(unique(c(
    as.character(sc0$HomeTeam), as.character(sc0$AwayTeam),
    as.character(sc1$HomeTeam), as.character(sc1$AwayTeam),
    as.character(sc2$HomeTeam), as.character(sc2$AwayTeam),
    as.character(sc3$HomeTeam), as.character(sc3$AwayTeam)
  )))
}

tm <- engsoccerdata::teamnames

raw23 <- get_scotland_raw_teams(2023)
raw24 <- get_scotland_raw_teams(2024)

missing23 <- setdiff(raw23, tm$name_other)
missing24 <- setdiff(raw24, tm$name_other)

missing23
missing24
length(missing23)
length(missing24)

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Scotland",
          name = c("The Spartans"),
          name_other = c("Spartans"),
          most_recent = NA
        )
  )

## update steps
usethis::use_data(teamnames, overwrite = T)
write.csv(teamnames,'data-raw/teamnames.csv',row.names=F)
devtools::load_all()


sco23 <- scotland_current(Season=2023)
sco24 <- scotland_current(Season=2024)
sum(is.na(sco23$home)); sum(is.na(sco23$visitor))
sum(is.na(sco24$home)); sum(is.na(sco24$visitor))




sco22 <- engsoccerdata::scotland_current(Season = 2022)
sco23 <- engsoccerdata::scotland_current(Season = 2023)
sco24 <- engsoccerdata::scotland_current(Season = 2024)

# QC: should all be 0 now
sum(is.na(sco22$home)); sum(is.na(sco22$visitor))
sum(is.na(sco23$home)); sum(is.na(sco23$visitor))
sum(is.na(sco24$home)); sum(is.na(sco24$visitor))

# QC: counts by season/tier
bind_rows(sco22, sco23, sco24) %>% count(Season, tier)


library(dplyr)

sc_old <- engsoccerdata::scotland %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

sc_new_in <- bind_rows(sco22, sco23, sco24) %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

sc_merged <- bind_rows(sc_old, sc_new_in) %>%
  distinct(Date, Season, division, tier, home, visitor, .keep_all = TRUE) %>%
  arrange(Date, tier, division)

# store Date as character (your convention)
sc_merged$Date <- as.character(sc_merged$Date)

# replace + save
scotland <- sc_merged
usethis::use_data(scotland, overwrite = TRUE)

# optional csv snapshot (only if you maintain these)
write.csv(scotland, "data-raw/scotland.csv", row.names = FALSE)

# Should now be 2024
max(scotland$Season)

# Verify the added seasons exist and look sane
scotland %>% filter(Season %in% 2022:2024) %>% count(Season, tier)

# Duplicate key check (should be 0)
dup_check <- scotland %>%
  count(Date, Season, division, tier, home, visitor) %>%
  filter(n > 1)
nrow(dup_check)

# Confirm ordering by date
head(scotland$Date)
tail(scotland$Date)
dim(scotland)
