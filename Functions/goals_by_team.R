#### Return all instances of a team scoring n goals

goals_by_team<-function (df, goals, teamname) {
  
  library(dplyr)
  library(tidyr)
  df%>%
    filter(hgoal>=goals & home==teamname | vgoal>=goals & visitor == teamname) %>%
    select(Date,Season,home,visitor,FT, division,tier) %>%
    arrange(Season)
}


#Examples
goals_by_team(df, 7, "York City")
goals_by_team(df, 8, "Manchester United")
goals_by_team(df, 9, "Aston Villa")






