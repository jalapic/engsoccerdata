### england nonleague munge

head(england_nonleague)
tail(england_nonleague)

table(england_nonleague$Season, england_nonleague$tier)

maketable_all(england_nonleague %>% filter(Season==2018, tier==5))

#solihull - fyle - tier5, season 2018

england_nonleague %>%
  filter(home == "AFC Fylde"|home=="Solihull") %>%
  filter(visitor == "AFC Fylde"|visitor=="Solihull")



library(tidyverse)
england %>%
  filter(Season>2016) %>%
  group_by(tier,Season) %>%
  count()

e01 = england_current(Season=2020)  #
e01
e01[is.na(e01$home),]
tail(e01)

e01 = england_current(Season=2021)  #
e01
e01[is.na(e01$home),]
e01[is.na(e01$visitor),]
head(e01)
tail(e01)

e01 = england_current(Season=2022)  #
e01
e01[is.na(e01$home),]
e01[is.na(e01$visitor),]

tail(e01)


#use check current teamnames
engsoccerdata::teamnames[grepl("rent", engsoccerdata::teamnames$name),]  #


# bind

ex<-
  rbind(
    england_current(Season=2020),
    england_current(Season=2021)
  )

england <- rbind(england,ex)

library(tidyverse)
england %>%
  filter(Season>2017) %>%
  group_by(tier,Season) %>%
  count() %>%
  as.data.frame()

tail(england)


## update steps
usethis::use_data(england, overwrite = T)
write.csv(england,'data-raw/england.csv',row.names=F)
devtools::load_all()

dim(england)
#update england.R

#update current

# redo documentation
devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks



























#
#
#
#
#
# head(england)
# tail(england)
#
# library(tidyverse)
#
# df <- england %>% filter(Season>2014)
# table(df$tier, df$Season)
#
# #update 2019-2020...
#
# # old_data <- engsoccerdata::england %>%
# #   filter(Season > 2014)
#
# year_links <- c("https://www.11v11.com/competitions/premier-league/2020/",
#                 "https://www.11v11.com/competitions/league-championship/2020/",
#                 "https://www.11v11.com/competitions/league-one/2020/",
#                 "https://www.11v11.com/competitions/league-two/2020/")
#
#
#
#
# league_data <- lapply(year_links[4], function(link) {
#   league_season <- as.numeric(gsub(".*\\/", "", gsub("\\/$", "", link))) - 1
#   if(grepl("premier-league", link)) {
#     division <- 1
#   }
#   if(grepl("championship", link)) {
#     division <- 2
#   }
#   if(grepl("league-one", link)) {
#     division <- 3
#   }
#   if(grepl("league-two", link)) {
#     division <- 4
#   }
#
#   match_links <- read_html(paste0(link, "matches/")) %>%
#     html_nodes(".score a") %>%
#     html_attr("href") %>%
#     paste0("https://www.11v11.com", .) %>%
#     unlist() %>%
#     unique()
#
#   data <- lapply(match_links, get_league_match_data, league_season = league_season, division = division) %>%
#     do.call(rbind, .)
# }) %>%
#   do.call(rbind, .)
#
#
# head(league_data)
# str(league_data)
#
# i <- sapply(league_data, is.factor)
# league_data[i] <- lapply(league_data[i], as.character)
#
# str(league_data)
#
#
# league_data %>%
#   mutate(home = case_when(
#     grepl("Brighton and Hove", home) ~ "Brighton & Hove Albion",
#     grepl("Cheltenham Town", home) ~ "Cheltenham",
#     grepl("Stevenage", home) ~ "Stevenage Borough",
#     grepl("Macclesfield Town", home) ~ "Macclesfield",
#     grepl("Yeovil", home) ~ "Yeovil",
#     TRUE ~ home
#   )) %>%
#   mutate(visitor = case_when(
#     grepl("Brighton and Hove", visitor) ~ "Brighton & Hove Albion",
#     grepl("Cheltenham Town", visitor) ~ "Cheltenham",
#     grepl("Stevenage", visitor) ~ "Stevenage Borough",
#     grepl("Macclesfield Town", visitor) ~ "Macclesfield",
#     grepl("Yeovil", visitor) ~ "Yeovil",
#     TRUE ~ visitor
#   )) -> league_data
#
#
# head(league_data)
# tail(league_data)
#
# #
# #tier4 <- league_data
# #tier3 <- league_data
# #tier2 <- league_data
# #tier1 <- league_data
#
#
# ## bind to current dataset.
# str(england)
# str(tier1)
# str(tier2)
# str(tier3)
# str(tier4)
#
# tier1$Date<-as.character(tier1$Date)
# tier2$Date<-as.character(tier2$Date)
# tier3$Date<-as.character(tier3$Date)
# tier4$Date<-as.character(tier4$Date)
#
# tiers <- rbind(tier1,tier2,tier3,tier4)
#
# england <- rbind(england,tiers)
#
#
# ## update steps
# usethis::use_data(england, overwrite = T)
# write.csv(england,'data-raw/england.csv',row.names=F)
# devtools::load_all()
#
# # redo documentation   devtools::document()
# # rebuild
# # redo checks
#
#
#
# ### FUNCTIONS
# get_league_match_data <- function(link, league_season, division) {
#   check <<- link
#   read <- read_html(link)
#
#   date <- read %>%
#     html_nodes("h1") %>%
#     html_text() %>%
#     gsub(".*, ", "", .) %>%
#     as.Date(., "%d %B %Y")
#
#   season <- league_season
#   division <- division
#   tier <- division
#
#   home <- read %>%
#     html_nodes(".home .teamname a") %>%
#     html_text()
#   visitor <- read %>%
#     html_nodes(".away .teamname a") %>%
#     html_text()
#
#   hgoal <- read %>%
#     html_nodes(".home .score") %>%
#     html_text() %>%
#     gsub(" \\(.*", "", .) %>%
#     as.numeric()
#   vgoal <- read %>%
#     html_nodes(".away .score") %>%
#     html_text() %>%
#     gsub(" \\(.*", "", .) %>%
#     as.numeric()
#
#   FT <- paste0(hgoal, "-", vgoal)
#
#   if(hgoal == vgoal) {
#     result = "D"
#   } else {
#     if(hgoal > vgoal) {
#       result = "H"
#     } else {
#       result = "A"
#     }
#   }
#
#   data <- data.frame(Date = date, Season = season,
#                      home = home, visitor = visitor,
#                      FT = FT,
#                      hgoal = hgoal, vgoal = vgoal,
#                      division = division, tier = tier,
#                      totgoal = hgoal+vgoal,
#                      goaldif = hgoal - vgoal,
#                      result = result
#   )
# }
#
#


head(england_nonleague)
tail(england_nonleague)
table(england_nonleague$Season, england_nonleague$division)
