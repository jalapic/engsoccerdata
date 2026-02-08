### Tier 5 munging

library(dplyr)

england_nonleague %>%
  filter(tier == 5) %>%
  count(Season) %>%
  arrange(Season)

england_nonleague %>%
  filter(tier == 5) %>%
  count(Season, division) %>%
  arrange(Season, division) %>%
  as.data.frame()


library(dplyr)

england5 <- england_nonleague %>%
  filter(tier == 5) %>%
  mutate(
    Season = as.numeric(Season),
    # keep Date as character in final, but use Date parsing for ordering
    Date2 = as.Date(Date),
    division = "conference",   # unify for tier 5
    tier = 5
  ) %>%
  arrange(Date2, home, visitor) %>%
  select(-Date2)

# matches per season
england5 %>% count(Season) %>% arrange(Season)

# games per team per season (should be very uniform within a season)
check_team_games <- function(season){
  x <- england5 %>% filter(Season == season)
  sort(table(c(x$home, x$visitor)))
}

table(england5$Season)

check_team_games(2016)
check_team_games(2017)
check_team_games(2018)


expected_matches <- function(df_season){
  nteams <- length(unique(c(df_season$home, df_season$visitor)))
  nteams * (nteams - 1)   # double round-robin matches
}

expected_matches(england5 %>% filter(Season==2016))


tail(england5 %>% filter(Season==2016), 10)
tail(england5 %>% filter(Season==2017),10)
tail(england5 %>% filter(Season==2018),10)

england5 %>% filter(Season==2017) %>% nrow()

england5 %>% filter(Season==2017) %>% arrange(as.Date(Date)) %>% tail(12)
england5 %>% filter(Season==2017) %>% arrange(as.Date(Date)) %>% head(12)

england5 %>% filter(Season==2017) %>% filter(home=="Boreham Wood",
                                             visitor=="Ebbsfleet United")

england5 %>% filter(Season==2017) %>% filter(home=="Tranmere Rovers",
                                             visitor=="Ebbsfleet United")

df <- england5 %>% filter(Season==2017) %>% arrange(as.Date(Date)) %>% head(554)
table(df$home,df$visitor)  #Maidenhead Sutton,  #Fylde, Maidstone

# remove abandoned games
england5 %>% filter(Season==2017) %>% filter(home=="Maidenhead United",
                                             visitor=="Sutton United")

england5 %>% filter(Season==2017) %>% filter(home=="AFC Fylde",
                                             visitor=="Maidstone United")

e5_17 <- england5 %>% filter(Season==2017) %>% arrange(as.Date(Date))
e5_17 %>% as.data.frame()
nrow(e5_17)
check_team_games(e5_17, 2017)

which(e5_17$home=="Maidenhead United" & e5_17$visitor=="Sutton United")
e5_17 <- e5_17[-471,]
nrow(e5_17)

which(e5_17$home=="AFC Fylde" & e5_17$visitor=="Maidstone United")
e5_17[180,]
e5_17 <- e5_17[-180,]
nrow(e5_17)

e5_17 <- e5_17[1:552,]
nrow(e5_17)
check_team_games(e5_17, 2017)


# Always sort first before head()
e5_16 <- england5 %>% filter(Season==2016) %>% arrange(as.Date(Date)) %>% head(552)
e5_18 <- england5 %>% filter(Season==2018) %>% arrange(as.Date(Date)) %>% head(552)

# Compare team-games distribution
check_team_games <- function(df, season){
  x <- df %>% filter(Season == season)
  sort(table(c(x$home, x$visitor)))
}

check_team_games(e5_16, 2016)
check_team_games(e5_17, 2017)
check_team_games(e5_18, 2018)

england5_clean <- rbind(england5 %>% filter(Season<2016), e5_16,e5_17,e5_18)

england5 <- england5_clean

usethis::use_data(england5, overwrite = TRUE)
write.csv(england5, "data-raw/england5.csv", row.names = FALSE)
devtools::document()
devtools::check()

#### check teamname consistency

library(dplyr)

teams_england <- sort(unique(c(england$home, england$visitor)))
teams_england5 <- sort(unique(c(england5$home, england5$visitor)))

# Teams present in england5 but never appear in england
only_in_5 <- setdiff(teams_england5, teams_england)

# Teams present in england but never appear in england5
only_in_1to4 <- setdiff(teams_england, teams_england5)

length(teams_england5)
length(teams_england)
length(only_in_5)
length(only_in_1to4)

head(only_in_5, 50)

# "Dagenham"  "FC Halifax Town"  "Kettering Town"

unique(england$home)[grepl("ett", unique(england$home))]
unique(teamnames$name)[grepl("age", unique(teamnames$name))]

tm_england_canonical <- engsoccerdata::teamnames %>%
  filter(country == "England") %>%
  pull(name) %>%
  unique()

noncanonical_5 <- setdiff(teams_england5, tm_england_canonical)

length(noncanonical_5)
noncanonical_5

# noncanonical_5
# [1] "AFC Fylde"              "AFC Telford United"     "FC Halifax Town"
# [4] "Harrogate Town"         "Havant & Waterlooville" "Maidenhead United"
# >
#
tm_england_other <- engsoccerdata::teamnames %>%
  filter(country == "England") %>%
  pull(name_other) %>%
  unique()

alias_leaks_5 <- intersect(teams_england5, tm_england_other)

length(alias_leaks_5)
alias_leaks_5

unique(teamnames$name)[grepl("yl", unique(teamnames$name))] #Fylde
unique(teamnames$name)[grepl("rro", unique(teamnames$name))] #Harrogate Town A.F.C.
unique(teamnames$name)[grepl("elf", unique(teamnames$name))] #Telford United
unique(teamnames$name)[grepl("terl", unique(teamnames$name))] # x
unique(teamnames$name)[grepl("fax", unique(teamnames$name))] #Halifax Town
unique(teamnames$name)[grepl("denh", unique(teamnames$name))] #Maidenhead

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "England",
          name = c("Havant & Waterlooville","Fylde","Harrogate Town A.F.C.",
                   "Halifax Town","Maidenhead","Telford United"),
          name_other = c("Havant & Waterlooville","AFC Fylde","Harrogate Town",
                         "FC Halifax Town","Maidenhead United","AFC Telford United"),
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



#update teamnames to canonical

library(dplyr)

tm_eng <- teamnames %>%
  filter(country == "England") %>%
  select(name, name_other)

# Standardize england5 team names using name_other -> name
england5 <- england5 %>%
  mutate(
    home_std = tm_eng$name[match(home, tm_eng$name_other)],
    visitor_std = tm_eng$name[match(visitor, tm_eng$name_other)]
  )

# Guard: if anything didn't map, warn and print them
bad_home <- sort(unique(england5$home[is.na(england5$home_std)]))
bad_vis  <- sort(unique(england5$visitor[is.na(england5$visitor_std)]))

if(length(bad_home) > 0 || length(bad_vis) > 0){
  warning(
    "england5 teamnames not fully matched. Missing home: ",
    paste(bad_home, collapse=", "),
    " | Missing visitor: ",
    paste(bad_vis, collapse=", ")
  )
}

# Replace only where mapping exists; otherwise keep original
england5 <- england5 %>%
  mutate(
    home = ifelse(is.na(home_std), home, home_std),
    visitor = ifelse(is.na(visitor_std), visitor, visitor_std)
  ) %>%
  select(-home_std, -visitor_std)


teams_england5 <- sort(unique(c(england5$home, england5$visitor)))
tm_eng_canon <- unique(tm_eng$name)

noncanonical_5 <- setdiff(teams_england5, tm_eng_canon)
noncanonical_5


#Ebbsfleet United, Grays Athletic, Salford City, St Albans
unique(teamnames$name_other)[grepl("bbs", unique(teamnames$name_other))] ##Ebbsfleet United

unique(teamnames$name_other)[grepl("rays", unique(teamnames$name_other))] ##Grays Athletic
unique(teamnames$name)[grepl("rays", unique(teamnames$name))] ##Grays Athletic

unique(teamnames$name_other)[grepl("alf", unique(teamnames$name_other))] ##Salford City
unique(teamnames$name)[grepl("alf", unique(teamnames$name))] ##Salford City

unique(teamnames$name_other)[grepl("ban", unique(teamnames$name_other))] ##St Albans
unique(teamnames$name)[grepl("ban", unique(teamnames$name))] ##St. Albans

teamnames <- rbind(
  teamnames,
  data.frame(country="England", name="Ebbsfleet United", name_other="Ebbsfleet United", most_recent=NA),
  data.frame(country="England", name="Grays Athletic",   name_other="Grays Athletic",   most_recent=NA),
  data.frame(country="England", name="Salford City",     name_other="Salford City",     most_recent=NA),
  data.frame(country="England", name="St. Albans",   name_other="St Albans",        most_recent=NA)
)

head(teamnames)
tail(teamnames)

## update steps
usethis::use_data(teamnames, overwrite = T)
write.csv(teamnames,'data-raw/teamnames.csv',row.names=F)
# redo documentation
devtools::document()



tm_eng <- teamnames %>%
  filter(country == "England") %>%
  select(name, name_other)

england5 <- engsoccerdata::england5 %>%
  mutate(
    home_std = tm_eng$name[match(home, tm_eng$name_other)],
    visitor_std = tm_eng$name[match(visitor, tm_eng$name_other)]
  )

bad_home <- sort(unique(england5$home[is.na(england5$home_std)]))
bad_vis  <- sort(unique(england5$visitor[is.na(england5$visitor_std)]))

bad_home
bad_vis


england5 <- england5 %>%
  mutate(
    home = ifelse(is.na(home_std), home, home_std),
    visitor = ifelse(is.na(visitor_std), visitor, visitor_std)
  ) %>%
  select(-home_std, -visitor_std)


usethis::use_data(teamnames, overwrite = TRUE)
write.csv(teamnames, "data-raw/teamnames.csv", row.names = FALSE)

usethis::use_data(england5, overwrite = TRUE)
write.csv(england5, "data-raw/england5.csv", row.names = FALSE)

devtools::document()
devtools::check()

##### 2019 onwards

#fix teamnames
# "Boston Utd"     "Dorking"        "Oxford City"    "King\x92s Lynn"


unique(teamnames$name_other)[grepl("yn", unique(teamnames$name_other))] ##
unique(teamnames$name)[grepl("yn", unique(teamnames$name))] ##

teamnames <- rbind(
  teamnames,
  data.frame(country="England", name="Boston United", name_other="Boston Utd", most_recent=NA),
  data.frame(country="England", name="Dorking",   name_other="Dorking",   most_recent=NA),
  data.frame(country="England", name="Oxford City",     name_other="Oxford City",     most_recent=NA),
  data.frame(country="England", name="King's Lynn",   name_other="King\x92s Lynn",        most_recent=NA)
)

head(teamnames)
tail(teamnames)

## update steps
usethis::use_data(teamnames, overwrite = T)
write.csv(teamnames,'data-raw/teamnames.csv',row.names=F)
# redo documentation
devtools::document()

library(dplyr)

pull_england5_season <- function(Season){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1
  url <- paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/EC.csv")

  df <- utils::read.csv(url)
  out <- engsoccerdata::getCurrentData(df, division = 5, tier = 5, Season = Season)

  # Standardize names using England mappings
  tm_eng <- engsoccerdata::teamnames %>% filter(country == "England") %>% select(name, name_other)
  out$home <- tm_eng$name[match(out$home, tm_eng$name_other)]
  out$visitor <- tm_eng$name[match(out$visitor, tm_eng$name_other)]

  # keep Date as character for dataset storage (your preference)
  out$Date <- as.character(out$Date)

  out
}

e19 <- pull_england5_season(2019)
tail(e19,11)
e19$home[is.na(e19$home)]
e19$visitor[is.na(e19$visitor)]
# truncated season - ok


e20 <- pull_england5_season(2020)
nrow(e20)  #why is it 477?
tail(e20,11)
head(e20,21)
#Dover, Macclesfield expunged records.
e20$home[is.na(e20$home)]
e20$visitor[is.na(e20$visitor)]
e20 <- e20 %>% filter(home!="Dover Athletic") %>% filter(visitor!="Dover Athletic")
nrow(e20)
(22*21)
# ok now ok



e21 <- pull_england5_season(2021)
nrow(e21)  #
tail(e21,11)
head(e21,21)
e21$home[is.na(e21$home)]
e21$visitor[is.na(e21$visitor)]



e22 <- pull_england5_season(2022)
nrow(e22)  #
tail(e22,11)
head(e22,11)
e22$home[is.na(e22$home)]
e22$visitor[is.na(e22$visitor)]


e23 <- pull_england5_season(2023)
nrow(e23)  #
tail(e23,11)
head(e23,11)
e23$home[is.na(e23$home)]
e23$visitor[is.na(e23$visitor)]



e24 <- pull_england5_season(2024)
nrow(e24)  #
tail(e24,11)
head(e24,11)
e24$home[is.na(e24$home)]
e24$visitor[is.na(e24$visitor)]



sapply(list(e19=e19,e20=e20,e21=e21,e22=e22,e23=e23,e24=e24), nrow)


na_qc <- rbind(
  `2019` = c(home_na=sum(is.na(e19$home)), visitor_na=sum(is.na(e19$visitor))),
  `2020` = c(home_na=sum(is.na(e20$home)), visitor_na=sum(is.na(e20$visitor))),
  `2021` = c(home_na=sum(is.na(e21$home)), visitor_na=sum(is.na(e21$visitor))),
  `2022` = c(home_na=sum(is.na(e22$home)), visitor_na=sum(is.na(e22$visitor))),
  `2023` = c(home_na=sum(is.na(e23$home)), visitor_na=sum(is.na(e23$visitor))),
  `2024` = c(home_na=sum(is.na(e24$home)), visitor_na=sum(is.na(e24$visitor)))
)
na_qc

tm <- engsoccerdata::teamnames %>% filter(country=="England")

get_england5_raw_teams <- function(Season){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1
  url <- paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/EC.csv")
  df <- utils::read.csv(url)

  sort(unique(c(as.character(df$HomeTeam), as.character(df$AwayTeam))))
}




raw19 <- get_england5_raw_teams(2019)
raw20 <- get_england5_raw_teams(2020)
raw21 <- get_england5_raw_teams(2021)
raw22 <- get_england5_raw_teams(2022)
raw23 <- get_england5_raw_teams(2023)
raw24 <- get_england5_raw_teams(2024)

missing_all <- sort(unique(c(
  setdiff(raw19, tm$name_other),
  setdiff(raw20, tm$name_other),
  setdiff(raw21, tm$name_other),
  setdiff(raw22, tm$name_other),
  setdiff(raw23, tm$name_other),
  setdiff(raw24, tm$name_other)
)))
missing_all


fix_england5_types <- function(x){
  x$Date <- as.character(x$Date)         # keep Date as character in stored dataset
  x$Season <- as.numeric(x$Season)
  x$tier <- as.numeric(x$tier)

  # standardize division to character and use your label
  x$division <- as.character(x$division)
  x$division[x$division %in% c("5", "5.0")] <- "conference"  # just in case

  x
}

england5_old <- fix_england5_types(england5 %>% filter(Season <= 2018))

e19 <- fix_england5_types(e19); e19$division <- "conference"
e20 <- fix_england5_types(e20); e20$division <- "conference"
e21 <- fix_england5_types(e21); e21$division <- "conference"
e22 <- fix_england5_types(e22); e22$division <- "conference"
e23 <- fix_england5_types(e23); e23$division <- "conference"
e24 <- fix_england5_types(e24); e24$division <- "conference"

england5_new <- bind_rows(england5_old, e19,e20,e21,e22,e23,e24) %>%
  arrange(as.Date(Date), home, visitor)

max(england5_new$Season)

table(england5_new$Season)
sum(is.na(england5_new$home)); sum(is.na(england5_new$visitor))
unique(england5_new$division)

england5 <- england5_new
usethis::use_data(england5, overwrite = TRUE)
write.csv(england5, "data-raw/england5.csv", row.names = FALSE)
devtools::document()
devtools::check()

