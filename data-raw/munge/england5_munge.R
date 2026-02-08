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


