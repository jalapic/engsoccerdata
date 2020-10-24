
Season=2020
myseason<-Season
division<-1
tier<-1

s2<-as.numeric(substr(myseason,3,4))
  s1 <- s2+1

  #b1=read.csv(paste0("http://www.football-data.co.uk/mmz4281/",s2,s1,"/D1.csv"))
  #b2=read.csv(paste0("http://www.football-data.co.uk/mmz4281/",s2,s1,"/D2.csv"))
 # f1=read.csv(paste0("http://www.football-data.co.uk/mmz4281/",s2,s1,"/F1.csv"))
  #b1<- read.csv(paste0("http://www.football-data.co.uk/mmz4281/",s2,s1,"/B1.csv"))
  #g1=read.csv(paste0("http://www.football-data.co.uk/mmz4281/",s2,s1,"/G1.csv"))
  n1=read.csv(paste0("http://www.football-data.co.uk/mmz4281/",s2,s1,"/N1.csv"))

  df<-n1

  head(df)

df<-  data.frame("Date" = as.character(as.Date(df$Date, "%d/%m/%Y")),
             "Season" = Season,
             "home" = as.character(df$HomeTeam),
             "visitor" = as.character(df$AwayTeam),
             "FT" = paste0(df$FTHG, "-", df$FTAG),
             "hgoal" = df$FTHG,
             "vgoal" = df$FTAG,
             "division" = division,
             "tier" = tier,
             "totgoal" = df$FTHG + df$FTAG,
             "goaldif" = df$FTHG - df$FTAG,
             "result" = as.character(ifelse(df$FTHG > df$FTAG, "H",
                                            ifelse(df$FTHG < df$FTAG, "A", "D")))
             , stringsAsFactors = FALSE)


df
head(df)

xx<-  unique(c(df$home, df$visitor))

xx

xx %in% teamnames$name
xx %in% teamnames$name_other

xx[!xx %in% teamnames$name_other]


df1<-df
df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")

str(df1)

df1$visitor %in% tm$name_other

nrow(tm)

tm <- engsoccerdata::teamnames
df1$home <- tm$name[match(df1$home,tm$name_other)]
df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
