
## Germany munge


library(tidyverse)

tail(germany)

germany %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()


tst <- germany_current(Season=2020)
tst[is.na(tst$home),]

tst <- germany_current(Season=2021)
tst[is.na(tst$home),]

tst <- germany_current(Season=2022)
tst[is.na(tst$home),]
tst %>% filter(tier==2)

g1=read.csv("https://www.football-data.co.uk/mmz4281/2021/D1.csv")
g2=read.csv("https://www.football-data.co.uk/mmz4281/2021/D2.csv")



ex<-
  rbind(
    germany_current(Season=2020),
    germany_current(Season=2021)
  )

head(ex)
tail(ex, 50)

ex[is.na(ex$home),]


teams <- unique(c(as.character(ex$home),as.character(ex$visitor)))
teams %in% teamnames$name



# bind
germany <- rbind(germany,ex)

germany %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()


## update steps
usethis::use_data(germany, overwrite = T)
write.csv(germany,'data-raw/germany.csv',row.names=F)
devtools::load_all()

dim(germany)
#update germany.R


# redo documentation   devtools::document()
devtools::load_all()

devtools::document()


# rebuild
# redo checks
#######################

library(dplyr)

# Pull finished seasons
g23 <- engsoccerdata::germany_current(Season = 2023)
g24 <- engsoccerdata::germany_current(Season = 2024)

# QC 1: teamname mapping (should be 0/0)
sum(is.na(g23$home)); sum(is.na(g23$visitor))
sum(is.na(g24$home)); sum(is.na(g24$visitor))


# helper to fetch raw team strings for a season from football-data
get_germany_raw_teams <- function(Season){
  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1
  d1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/D1.csv"))
  d2 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/D2.csv"))
  sort(unique(c(as.character(d1$HomeTeam), as.character(d1$AwayTeam),
                as.character(d2$HomeTeam), as.character(d2$AwayTeam))))
}

raw22 <- get_germany_raw_teams(2022)
raw23 <- get_germany_raw_teams(2023)
raw24 <- get_germany_raw_teams(2024)

tm <- engsoccerdata::teamnames

missing22 <- setdiff(raw22, tm$name_other)
missing23 <- setdiff(raw23, tm$name_other)
missing24 <- setdiff(raw24, tm$name_other)

missing22
missing23
missing24
length(missing23)
length(missing24)


engsoccerdata::teamnames[engsoccerdata::teamnames$country=="Germany" &
                           grepl("Elversberg|Preußen Münster|Ulm|",
                                 engsoccerdata::teamnames$name), ]



#update teamnames
tn_path <- "data-raw/teamnames.csv"
tn <- read.csv(tn_path, stringsAsFactors = FALSE)

# create a data.frame template of missing rows (you will fill the canonical 'name')
new_rows <- data.frame(
  country = "Germany",
  name = NA_character_,
  name_other = c(missing23, missing24),
  most_recent = NA
) %>% distinct()

new_rows[1,2] <- "SV Elversberg"
new_rows[2,2] <- "Preussen Munster"
new_rows[3,2] <- "SSV Ulm 1846"
new_rows

unique(germany$visitor)[grepl("lm", unique(germany$visitor))]
unique(germany$visitor)[grepl("vers", unique(germany$visitor))]

tn2 <- bind_rows(tn, new_rows) %>% distinct()
write.csv(tn2, tn_path, row.names = FALSE)

teamnames <- tn2
usethis::use_data(teamnames, overwrite = TRUE)
devtools::load_all()

g23 <- germany_current(Season = 2023)
g24 <- germany_current(Season = 2024)
sum(is.na(g23$home)); sum(is.na(g23$visitor))
sum(is.na(g24$home)); sum(is.na(g24$visitor))


# QC 2: row counts
nrow(g23); nrow(g24)

# QC 3: counts by tier/division (Germany should usually be 306 per tier)
table(g23$tier)
table(g24$tier)

# QC 4: date ranges
range(as.Date(g23$Date))
range(as.Date(g24$Date))

# QC 5: compare to last stored season size
max(germany$Season)
germany %>% filter(Season == max(Season)) %>% count(tier)

table(germany$Season, germany$tier)




library(dplyr)

seasons_to_add <- 2022:2024

g_list <- lapply(seasons_to_add, function(s) engsoccerdata::germany_current(Season = s))
names(g_list) <- as.character(seasons_to_add)

# QC A: NA names
na_qc <- sapply(g_list, function(df) c(home_na = sum(is.na(df$home)), visitor_na = sum(is.na(df$visitor))))
t(na_qc)

# QC B: rows + tier counts + date ranges
qc_table <- lapply(g_list, function(df) {
  data.frame(
    n = nrow(df),
    min_date = as.character(min(as.Date(df$Date))),
    max_date = as.character(max(as.Date(df$Date)))
  )
})
qc_table

tier_counts <- lapply(g_list, function(df) table(df$tier))
tier_counts

library(dplyr)

g_old <- engsoccerdata::germany

# Temporarily convert Date to Date for ordering/deduping; keep division as label
g_old <- g_old %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

# Bind all new seasons
g_new_in <- bind_rows(g_list)

# Ensure types match for merge (Date as Date temporarily; division as character)
g_new_in <- g_new_in %>%
  mutate(
    Date = as.Date(Date),
    division = as.character(division),
    Season = as.numeric(Season)
  )

# Merge + dedupe by stable key
g_merged <- bind_rows(g_old, g_new_in) %>%
  distinct(Date, Season, division, tier, home, visitor, .keep_all = TRUE) %>%
  arrange(Date, tier, division)

# Convert Date back to character for storage (your convention)
g_merged$Date <- as.character(g_merged$Date)

# Assign and save
germany <- g_merged
usethis::use_data(germany, overwrite = TRUE)

# Optional snapshot
write.csv(germany, "data-raw/germany.csv", row.names = FALSE)


max(germany$Season)

germany %>%
  filter(Season %in% 2022:2024) %>%
  count(Season, tier)

# Duplicate check (should be 0)
dup_check <- germany %>%
  count(Date, Season, division, tier, home, visitor) %>%
  filter(n > 1)
nrow(dup_check)
