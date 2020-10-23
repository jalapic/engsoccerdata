



england_current <-  function(Season=2018){
  d <- england_current2(england_current1(Season=Season))
  return(d)
}

england_current1 <- function(Season = 2018){

  s1 <- s2 <- myseason <- tm <- df1 <- df <- . <- Date <- tier <- home <- visitor <- hgoal <- vgoal <- goaldif <- FT <- division <- result <- name <- name_other <- most_recent <- country <- NULL

  myseason <- Season
  s2 <- as.numeric(substr(myseason, 3, 4))
  s1 <- s2 + 1

  df <- rbind(read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E0.csv")),
              read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E1.csv")),
              read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E2.csv")),
              read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E3.csv"))
  )

  df <- df[1:8]
  df$Date <- as.Date(df$Date, "%d/%m/%y")

  head(df)


  engl <- max(engsoccerdata::england$Date)

  if (identical(max(as.Date(df$Date, "%d/%m/%y")), eng1)))
    warning("The returned dataframe contains data already included in 'england' dataframe")

  df1 <- data.frame(Date = df$Date,
                    Season = myseason,
                    home = as.character(df$HomeTeam),
                    visitor = as.character(df$AwayTeam),
                    FT = paste0(df$FTHG,"-", df$FTAG),
                    hgoal = df$FTHG,
                    vgoal = df$FTAG,
                    division = as.numeric(factor(df$Div)),
                    tier = as.numeric(factor(df$Div)),
                    totgoal = df$FTHG + df$FTAG,
                    goaldif = df$FTHG - df$FTAG,
                    result = as.character(df$FTR)
  )

  i <- sapply(df1, is.factor)
  df1[i] <- lapply(df1[i], as.character)
  df1$Date <- as.character(df1$Date)

  return(df1)
}


tail(df1)
str(df1)


















x <- unique(england$home)
y <- unique(df1$home)


x[grepl("orest",x)]

y[unique(y) %in% x]
y[!unique(y) %in% x]


vals <- y[!unique(y) %in% x]
vals

head(teamnames)

vals[vals %in% teamnames$name_other]
vals[!vals %in% teamnames$name_other]  # need to add in Salford and Harrogate

#Harrogate Town A.F.C.
#Salford City

tail(teamnames)

teamnames <-
rbind(teamnames,
data.frame(
  country = "England",
  name = c("Harrogate Town A.F.C.", "Salford City"),
  name_other = c("Harrogate", "Salford"),
  most_recent = NA
  )
)

head(teamnames)
tail(teamnames)

## update steps
usethis::use_data(teamnames, overwrite = T)
write.csv(teamnames,'data-raw/teamnames.csv',row.names=F)
# redo documentation   devtools::document()
# rebuild
# redo checks
teamnames<-
rbind(teamnames,
data.frame(
  country = c(rep("Portugal",5), rep("Italy",2), rep("England",2)),
  name = c("SC Farense", "Oliveirense","Academica","Mafra","CD Cova da Piedade","Parma Calcio 1913","Parma", "Salford City", "Harrogate Town A.F.C."),
  name_other = c("SC Farense", "Oliveirense", "Academica", "Mafra", "CD Cova da Piedade","Parma","Parma","Salford City", "Harrogate Town A.F.C."),
  most_recent = c(TRUE,TRUE,TRUE,TRUE,TRUE,NA,NA,NA,NA)
)
)

tail(teamnames)




library(tidyverse)
xx<-read_csv("https://raw.githubusercontent.com/jalapic/engsoccerdata/master/data-raw/teamnames.csv")
nrow(xx)
tail(xx)

teamnames<-
  rbind(xx,
        data.frame(
          country = c(rep("Germany",4)),
          name = c("1. FC Magdeburg", "SC Paderborn 07", "SV Wehen Wiesbaden", "VfL Osnabruck"),
          name_other = c("Magdeburg", "Paderborn", "Wehen","Osnabruck"),
          most_recent = c(NA,NA,NA,NA)
        )
  )
tail(teamnames)
## update steps
usethis::use_data(teamnames, overwrite = T)
write.csv(teamnames,'data-raw/teamnames.csv',row.names=F)
nrow(teamnames)
devtools::load_all()

# redo documentation   devtools::document()
# rebuild
# redo checks
