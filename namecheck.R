### Function to check what characters exist in which team names

namecheck<-function(df,x){
  teams<-unique(df$home)
  teams.nos<-grep(x, teams)
  teams.res<- vector("list",length(teams.nos)) #this vector stores the results of the loop
  for (i in 1:length(teams.nos)){  #there are 93 files
    
    y<-teams.nos[[i]]
    teams.res[[i]] <- as.character(teams[[y]])
  }  
  
  temp<-as.data.frame(unlist(teams.res))
  colnames(temp)<-c("team")
  library(dplyr)
  temp1 <- temp %>% arrange (team)
  return(temp1) 
}

#Examples
namecheck(df, "hester")
namecheck(df, "United")
namecheck(df, "Athletic")
namecheck(df, "Rovers")
namecheck(df, "x"