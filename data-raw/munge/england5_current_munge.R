
teamnames <- rbind(
  teamnames,
  data.frame(country="England", name="Truro City",   name_other="Truro",
             most_recent=NA)
)

head(teamnames)
tail(teamnames)

## update steps
usethis::use_data(teamnames, overwrite = T)
write.csv(teamnames,'data-raw/teamnames.csv',row.names=F)
# redo documentation
devtools::document()


####

e5_25 <- england5_current(Season = 2025)


str(e5_25)
head(e5_25)
tail(e5_25)


req <- c("Date","Season","home","visitor","FT","hgoal","vgoal","division","tier","totgoal","goaldif","result")
setdiff(req, names(e5_25))          # should be character(0)
sapply(e5_25[req], class)


sum(is.na(e5_25$home))
sum(is.na(e5_25$visitor))

sort(unique(c(e5_25$home[is.na(e5_25$home)], e5_25$visitor[is.na(e5_25$visitor)])))


range(e5_25$Date, na.rm = TRUE)     # should be within 2025-08.. to “today-ish”
summary(e5_25$Date)


stopifnot(all(grepl("^[0-9]+-[0-9]+$", e5_25$FT)))
stopifnot(all(e5_25$totgoal == e5_25$hgoal + e5_25$vgoal))
stopifnot(all(e5_25$goaldif == e5_25$hgoal - e5_25$vgoal))

table(e5_25$result)                # H/A/D distribution

unique(e5_25$tier)                  # should be 5
unique(e5_25$division)              # should be 5 or "conference"/"EC" etc (whatever your standard is)


dup_n <- sum(duplicated(e5_25[, c("Date","home","visitor")]))
dup_n


max(as.Date(england5$Date))
max(e5_25$Date)

# overlap check
sum(as.Date(england5$Date) %in% e5_25$Date)



