### Function to List all games ever between two teams

games_between<-function (df, teamname1, teamname2) {
  library(dplyr)
  library(tidyr)
  x<-df[ which(df$home==teamname1 & df$visitor==teamname2),]
  x1<-df[ which(df$home==teamname2 & df$visitor==teamname1),]
  temp<-rbind(x,x1)
  if (nrow(temp)==0) stop ("These two teams have never played each other")
  temp %>% 
    select(Date,Season,home,visitor,FT,division,tier) %>%
    arrange(Season)
}

#Examples
games_between(df, "Aston Villa", "York City")
games_between(df, "Carlisle United", "Chelsea")
games_between(df, "Manchester United", "Milton Keynes Dons")
