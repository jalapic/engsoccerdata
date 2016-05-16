#' Function to List all games ever between two teams
#'
#' @param df The results dataframe
#' @param teamname1 teamname1
#' @param teamname2 teamname2
#' @return a dataframe of games between the two teams. If
#' they have never played will return an empty dataframe.
#' @examples
#' games_between(england, "Aston Villa", "York City")
#' games_between(england, "Carlisle United", "Chelsea")
#'
#' @export


games_between<-function(df=NULL, teamname1=NULL, teamname2=NULL) {

  DF <- df[(df$home==teamname1 & df$visitor==teamname2) | (df$home==teamname2 & df$visitor==teamname1),]
  DF <- DF[c('Date','Season','home','visitor','FT','tier')]
  DF <- DF[order(DF$Season),]
  return(DF)
}
