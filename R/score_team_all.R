#' Lists all matches that a team has played in that ended in a scoreline
#'
#' @param df df
#' @param score score
#' @param teamname teamname
#'
#' @examples
#' df <- engsoccerdata2
#' score_team.all(df, "1-0", "Arsenal")  # All games ending 1-0 or 0-1 involving Arsenal
#' score_team.all(df, "0-1", "Arsenal")  # All games ending 1-0 or 0-1 involving Arsenal
#' score_team.all(df, "4-3", "Coventry City")  # All games ending 4-3 or 3-4 involving Coventry City
#' score_team.all(df, "4-4", "Leeds United")  # All games ending 4-4 involving Leeds United
#'
#' @export
score_team.all<-function(df,score,teamname){
  temp<-strsplit(score,split="-")
  temp<-as.vector(unlist(temp[[1]]))
  score1<-paste(temp[2],temp[1],sep="-")
  df %>%
    filter(FT==score | FT==score1, home == teamname | visitor == teamname)%>%
    arrange(Season)
}
