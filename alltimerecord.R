### Function to List the all-time records of a team

alltimerecord<-function (df, teamname) {
  library(dplyr)
  library(tidyr)
  
  x<-df[ which(df$home==teamname),]
  x1<-df[ which(df$visitor==teamname),]
  temp<-rbind(x,x1)
  
  res <- x %>% group_by(result) %>% tally 
  res <-as.data.frame((unclass(res)))
  
  L<-res[res$result=="A",]
  D<-res[res$result=="D",]
  W<-res[res$result=="H",]
  
  gls <- x %>% summarise(FOR = sum(hgoal), AGAINST = sum(vgoal), DIF = sum(goaldif))
  gls$PLAYED <- nrow(x)
  
  gls$W <- ifelse (nrow(W)==0, 0, W[[2]])
  gls$D <- ifelse (nrow(D)==0, 0, D[[2]])
  gls$L <- ifelse (nrow(L)==0, 0, L[[2]])
  
  colnames(gls)<- c("FOR", "AGAINST", "DIF", "P", "W", "D", "L")
  home.record<-gls[c(4:7,1:3)]
  
  
  
  res <- x1 %>% group_by(result) %>% tally 
  res <-as.data.frame((unclass(res)))
  
  L<-res[res$result=="H",]
  D<-res[res$result=="D",]
  W<-res[res$result=="A",]
  
  gls <- x1 %>% summarise(FOR = sum(vgoal), AGAINST = sum(hgoal), DIF = (FOR-AGAINST))
  gls$PLAYED <- nrow(x)
  
  gls$W <- ifelse (nrow(W)==0, 0, W[[2]])
  gls$D <- ifelse (nrow(D)==0, 0, D[[2]])
  gls$L <- ifelse (nrow(L)==0, 0, L[[2]])
  
  colnames(gls)<- c("FOR", "AGAINST", "DIF", "P", "W", "D", "L")
  away.record<-gls[c(4:7,1:3)]
  
  b1<-as.matrix(home.record)
  b2<-as.matrix(away.record)
  b<-b1+b2
  record<-  rbind(home.record, away.record, b)
  
  rownames(record) <- c("home", "away", "total")
  return(record)
  
}

#Examples
alltimerecord(df, "Aston Villa")
alltimerecord(df, "Arsenal")
alltimerecord(df, "Liverpool")
alltimerecord(df, "Manchester United")
alltimerecord(df, "York City")
alltimerecord(df, "Rochdale")
alltimerecord(df, "Birmingham City")
alltimerecord(df, "Leeds City")
