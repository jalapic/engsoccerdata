#' Lists all matches that a team has played in that ended in a scoreline
#'
#' @param df the results dataset
#' @param score the scoreline
#' @param teamname the team
#' @return a dataframe of games ending in that result
#' @examples
#' score_team(england, "1-0", "Arsenal")  # All games ending 1-0 or 0-1 involving Arsenal
#' score_team(england, "4-3", "Coventry City")  # All games ending 4-3 or 3-4 involving Coventry City
#' @export


score_team<-function(df=NULL,score=NULL,teamname=NULL){
  temp<-strsplit(score,split="-")
  score1<-paste(temp[[1]][2],temp[[1]][1],sep="-")

  tmp <- df[(df$FT==score | df$FT==score1) & (df$home==teamname | df$visitor==teamname), ]
  tmp <- tmp[order(tmp$Season),]

  return(tmp)

}

