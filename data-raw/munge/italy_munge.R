### Italy Munge

####---------------------------------------------------------------------------####

i1=read.csv("https://www.football-data.co.uk/mmz4281/2021/I1.csv")

head(italy)
tail(italy)

library(tidyverse)
italy %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

table(italy$Season,italy$tier)

italy_current(Season=2020)  #

italy_current(Season=2021)  #


b <- read.csv("https://www.football-data.co.uk/mmz4281/2122/I1.csv")

b[1:10,1:5] #Salernitana;   Venezia

#use check current teamnames
engsoccerdata::teamnames[grepl("ern", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("enez", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Italy",
          name = c("Salernitana Calcio 1919", "AC Venezia"),
          name_other = c("Salernitana","Venezia"),
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

italy_current(Season=2021)  #



italy_current(Season=2022)  #

b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/I1.csv")

b[1:10,1:5] #Monza;   Cremonese

#use check current teamnames
engsoccerdata::teamnames[grepl("onz", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("remo", engsoccerdata::teamnames$name),]  #


teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Italy",
          name = c("AC Monza", "US Cremonese"),
          name_other = c("Monza","Cremonese"),
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

italy_current(Season=2022)  #


#use check current teamnames



# bind

italy %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()


ex<-
  rbind(
    italy_current(Season=2020),
    italy_current(Season=2021)
  )

italy <- rbind(italy,ex)

library(tidyverse)
italy %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(italy)


## update steps
usethis::use_data(italy, overwrite = T)
write.csv(italy,'data-raw/italy.csv',row.names=F)
devtools::load_all()

dim(italy)

#update italy.R

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks


###############################

max(italy$Season)
table(italy$Season)[(length(table(italy$Season))-5):length(table(italy$Season))]

i22 <- italy_current(Season=2022)
i23 <- italy_current(Season=2023)
i24 <- italy_current(Season=2024)

sum(is.na(i22$home)); sum(is.na(i22$visitor))
sum(is.na(i23$home)); sum(is.na(i23$visitor))
sum(is.na(i24$home)); sum(is.na(i24$visitor))

nrow(i22); nrow(i23); nrow(i24)

i25 <- italy_current(Season=2025)
sum(is.na(i25$home)); sum(is.na(i25$visitor))

get_raw_teams_onefile <- function(Season, code){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1
  df <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/", code, ".csv"))
  sort(unique(c(as.character(df$HomeTeam), as.character(df$AwayTeam))))
}

tm <- engsoccerdata::teamnames

raw24 <- get_raw_teams_onefile(2024, "I1")
raw25 <- get_raw_teams_onefile(2025, "I1")

missing24 <- setdiff(raw24, tm$name_other)
missing25 <- setdiff(raw25, tm$name_other)

missing_all <- sort(unique(c(missing24, missing25)))
missing_all


#use check current teamnames
engsoccerdata::teamnames[grepl("omo", engsoccerdata::teamnames$name),]  #
engsoccerdata::teamnames[grepl("isa", engsoccerdata::teamnames$name),]  #

teamnames <-
  rbind(teamnames[1:1413,],
        data.frame(
          country = "Italy",
          name = c("Pisa SC", "Como Calcio"),
          name_other = c("Pisa","Como"),
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


library(dplyr)

i22 <- engsoccerdata::italy_current(Season = 2022)
i23 <- engsoccerdata::italy_current(Season = 2023)
i24 <- engsoccerdata::italy_current(Season = 2024)

# QC: name mapping should be clean now
sum(is.na(i22$home)); sum(is.na(i22$visitor))
sum(is.na(i23$home)); sum(is.na(i23$visitor))
sum(is.na(i24$home)); sum(is.na(i24$visitor))

# QC: rows + date ranges
nrow(i22); nrow(i23); nrow(i24)
range(as.Date(i22$Date)); range(as.Date(i23$Date)); range(as.Date(i24$Date))

# Optional: verify tier/division
table(i22$tier)
table(i22$division)

head(italy)


it_old <- engsoccerdata::italy %>% filter(Season<2022) %>%
  mutate(
    Date = as.Date(Date),
    Season = as.numeric(Season)
  )

it_new_in <- bind_rows(i22, i23, i24) %>%
  mutate(
    Date = as.Date(Date),
    Season = as.numeric(Season)
  )

it_merged <- bind_rows(it_old, it_new_in) %>%
  distinct(Date, Season, tier, home, visitor, .keep_all = TRUE) %>%
  arrange(Date, tier)

# store Date as character (your convention)
it_merged$Date <- as.character(it_merged$Date)

italy <- it_merged
usethis::use_data(italy, overwrite = TRUE)

# optional snapshot (only if you maintain these)
write.csv(italy, "data-raw/italy.csv", row.names = FALSE)

# Post-merge QC
max(italy$Season)
italy %>% filter(Season %in% 2022:2024) %>% count(Season, tier)

dup_check <- italy %>%
  count(Date, Season, tier, home, visitor) %>%
  filter(n > 1)
nrow(dup_check)
dim(italy)


devtools::load_all()
i25 <- italy_current(Season = 2025)
sum(is.na(i25$home)); sum(is.na(i25$visitor))


italy %>% filter(Season==2023)

tail(teamnames)


#####################

#backfill italy columns

library(dplyr)

italy_fixed <- italy %>%
  mutate(
    # Keep Date as character (ensure consistent)
    Date = as.character(Date),

    # Ensure numeric goals
    hgoal = as.integer(hgoal),
    vgoal = as.integer(vgoal),

    # Ensure tier numeric (usually 1)
    tier = as.numeric(tier),

    # Standardize division: force to "1" everywhere (character)
    division = "1",

    # Backfill derived columns (overwrite NAs and standardize)
    totgoal = hgoal + vgoal,
    goaldif = hgoal - vgoal,
    result = ifelse(hgoal > vgoal, "H",
                    ifelse(hgoal < vgoal, "A", "D"))
  )

# QC quick checks
sum(is.na(italy_fixed$totgoal))
sum(is.na(italy_fixed$goaldif))
sum(is.na(italy_fixed$result))
table(italy_fixed$division, useNA = "ifany")
table(italy_fixed$result, useNA = "ifany")

# Replace and save back into package
italy <- italy_fixed
usethis::use_data(italy, overwrite = TRUE)

# optional csv snapshot
write.csv(italy, "data-raw/italy.csv", row.names = FALSE)

i25 <- italy_current(Season = 2025)

setdiff(colnames(italy), colnames(i25))
setdiff(colnames(i25), colnames(italy))

