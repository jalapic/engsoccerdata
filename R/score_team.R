#' List all occurrences of a specific scoreline for a specific team
#'
#' @examples
#' score_team (df,"4-4", "Tottenham Hotspur") #all 4-4 draws Tottenham Hotspur have played in (home and away)
#' score_team (df,"3-5", "York City")  #list all 5-3 defeats suffered by York City (regardless of if occurred home/away)
#' score_team (df,"5-3", "York City")  #list all 5-3 victories by York City (regardless of if occurred home/away)
#' score_team (df,"8-0", "Arsenal") #list all 8-0 victories by Arsenal (regardless of if occurred home/away)
#' score_team (df,"0-8", "Arsenal") #list all 8-0 defeats suffered by Arsenal (regardless of if occurred home/away)
#'
#' @export
score_team<-function (df, score, teamname) {
  library(dplyr)
  library(tidyr)

  temp<-strsplit(score,split="-")
  temp<-as.vector(unlist(temp[[1]]))
  score1<-paste(temp[2],temp[1],sep="-")

  df %>%
    filter(FT==score & home==teamname | FT==score1 & visitor==teamname) %>%
    select(Date, Season, home, visitor, FT, division, tier) %>%
    arrange(Season)

}
