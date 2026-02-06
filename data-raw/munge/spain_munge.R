####---------------------------------------------------------------------------####

### Spain Munge


head(spain)
tail(spain)

library(tidyverse)
spain %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

# only tier 1 data.

# check teams.


spain_current(Season=2020)  #
spain_current(Season=2021)  #
spain_current(Season=2022)


b <- read.csv("https://www.football-data.co.uk/mmz4281/2223/SP1.csv")
b[1:10,1:7] #Almeria

#use check current teamnames
engsoccerdata::teamnames[grepl("mer", engsoccerdata::teamnames$name),]  #
#UD Almeria

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Spain",
          name = c("UD Almeria"),
          name_other = c("Almeria"),
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


spain_current(Season=2022)



# bind

library(tidyverse)
spain %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

ex<-
  rbind(
    spain_current(Season=2020),
    spain_current(Season=2021)
  )

spain <- rbind(spain,ex)

library(tidyverse)
spain %>%
  filter(Season>2011) %>%
  group_by(tier,Season) %>%
  count()

tail(spain)


## update steps
usethis::use_data(spain, overwrite = T)
write.csv(spain,'data-raw/spain.csv',row.names=F)
devtools::load_all()

dim(spain)

#update spain.R

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

#rebuild
#redo checks

s23 <- spain_current(Season = 2023)
s24 <- spain_current(Season = 2024)

sum(is.na(s23$home)); sum(is.na(s23$visitor))
sum(is.na(s24$home)); sum(is.na(s24$visitor))

nrow(s23); nrow(s24)
range(as.Date(s23$Date)); range(as.Date(s24$Date))




####---------------------------------------------------------------------------####


library(dplyr)

# Pull the finished seasons
s23 <- engsoccerdata::spain_current(Season = 2023)
s24 <- engsoccerdata::spain_current(Season = 2024)

# Old data: temporarily cast Date to Date for dedupe/sort
sp_old <- engsoccerdata::spain
sp_old$Date <- as.Date(sp_old$Date)

# New data: ensure Date is Date for dedupe/sort
s23$Date <- as.Date(s23$Date)
s24$Date <- as.Date(s24$Date)

# Bind + dedupe (Spain has no division column; include tier + round to be safe)
sp_new <- bind_rows(sp_old, s23, s24) %>%
  distinct(Date, Season, home, visitor, tier, round, .keep_all = TRUE) %>%
  arrange(Date, tier, round)

# Save Date back as character (your preference)
sp_new$Date <- as.character(sp_new$Date)

# Replace + save into package
spain <- sp_new
usethis::use_data(spain, overwrite = TRUE)

# Optional snapshot (only if you keep these)
write.csv(spain, "data-raw/spain.csv", row.names = FALSE)

# QC
spain %>% filter(Season %in% c(2023, 2024)) %>% count(Season)
tail(spain)


library(dplyr)

# 1) Pull the missing season
s22 <- engsoccerdata::spain_current(Season = 2022)

# QC: should be 380, no NAs
nrow(s22)
sum(is.na(s22$home)); sum(is.na(s22$visitor))
range(as.Date(s22$Date))

# 2) Prepare existing + new for merge/sort
sp_old <- engsoccerdata::spain
sp_old$Date <- as.Date(sp_old$Date)

s22$Date <- as.Date(s22$Date)

# 3) Bind + dedupe + SORT by Date
sp_new <- bind_rows(sp_old, s22) %>%
  distinct(Date, Season, home, visitor, tier, round, .keep_all = TRUE) %>%
  arrange(Date, tier, round)

# 4) Store Date as character (your convention)
sp_new$Date <- as.character(sp_new$Date)

# 5) Save back into package
spain <- sp_new
usethis::use_data(spain, overwrite = TRUE)

# optional snapshot
write.csv(spain, "data-raw/spain.csv", row.names = FALSE)

# 6) Confirm seasons now include 2022 and are ordered
table(spain$Season)
head(spain$Date)
tail(spain$Date)

