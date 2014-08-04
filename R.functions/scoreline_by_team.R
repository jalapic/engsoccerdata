#### How often each team has a won,lost,drawn by a scoreline ? ####

scoreline_by_team<-function (df, score){
  library(dplyr)
  library(tidyr)
  
  temp<-strsplit(score,split="-")
  temp<-as.vector(unlist(temp[[1]]))
  score1<-paste(temp[2],temp[1],sep="-")
  
  x <- df %>%
    filter(FT==score1) %>%
    select(team = visitor) 
  
  y<- df %>%
    filter(FT==score) %>%
    select(team = home) 
  
  rbind(x,y) %>%  
    group_by(team)%>%
    tally %>%
    arrange(desc(n)) 
}

#Examples
scoreline_by_team(df,"8-0")  #number of times each team has won 8-0 (regardless of if occurred home/away)
scoreline_by_team(df,"0-8")  #number of times each team has lost 8-0 (regardless of if occurred home/away)
scoreline_by_team(df, "6-6") #number of times each team has drawn 6-6 (regardless of if occurred home/away)
scoreline_by_team(df, "7-5") #number of times each team has won 7-5 (regardless of if occurred home/away)
scoreline_by_team(df, "1-0") #number of times each team has won 1-0 (regardless of if occurred home/away)


#Note - teams with 0 occurrences will not be listed







