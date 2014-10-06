#' Function to check what characters exist in which team names
#'
#' @param df df
#' @param x x
#'
#' @examples
#' df <- engsoccerdata2
#' namecheck(df, "hester")
#' namecheck(df, "United")
#' namecheck(df, "Athletic")
#' namecheck(df, "Rovers")
#' namecheck(df, "x")
#'
#' @export
namecheck<-function(df,x){
  teams<-unique(df$home)
  teams.nos<-grep(x, teams)
  teams.res<- vector("list",length(teams.nos))
  for (i in 1:length(teams.nos)){

    y<-teams.nos[[i]]
    teams.res[[i]] <- as.character(teams[[y]])
  }

  temp<-as.data.frame(unlist(teams.res))
  colnames(temp)<-c("team")
  temp1 <- temp %>% arrange (team)
  return(temp1)
}
