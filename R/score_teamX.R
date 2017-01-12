#' List all occurrences of a specific scoreline for a specific team
#'
#' @param df the results dataset
#' @param score the scoreline
#' @param teamname the team
#' @return a dataframe of games ending in that result
#' @examples
#' score_teamX(england,"4-4", "Tottenham Hotspur")
#' #all 4-4 draws Tottenham Hotspur have played in (home and away)
#'
#' score_teamX(england,"3-5", "York City")
#' #list all 5-3 defeats suffered by York City (regardless of if occurred home/away)
#'
#' score_teamX(england,"5-3", "York City")
#' #list all 5-3 victories by York City (regardless of if occurred home/away)
#'
#' score_teamX(england,"8-0", "Arsenal")
#' #list all 8-0 victories by Arsenal (regardless of if occurred home/away)
#'
#' score_teamX(england,"0-8", "Arsenal")
#' #list all 8-0 defeats suffered by Arsenal (regardless of if occurred home/away)
#' @export


score_teamX<-function (df=NULL, score=NULL, teamname=NULL) {

  temp<-strsplit(score,split="-")
  score1<-paste(temp[[1]][2],temp[[1]][1],sep="-")

  tmp <- df[(df$FT==score & df$home==teamname) | (df$FT==score1 & df$visitor==teamname),]
  tmp <- tmp[order(tmp$Season),]

  return(tmp)

}
