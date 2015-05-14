#' Make a league table
#'
#' @param df dataframe that contains variables named 'home', 'visitor',
#' 'hgoal', 'vgoal'
#' @param points Points for a win. Default is 3.
#' @section Notes:
#' The table that is produced is based upon 3 points for a win (unless otherwise
#' defined), 1 for a draw and 0 for a loss.  The table is sorted based upon descending
#' GD and then descending GF as tie-breakers.
#' @examples
#' library(dplyr)
#' df <- engsoccerdata2 %>% filter(tier==1 & Season==2013)
#' maketable(df)
#' @export


maketable <- function(df, points=3){

  temp <-
    rbind(
      df %>% select(team=home, opp=visitor, GF=hgoal, GA=vgoal),
      df %>% select(team=visitor, opp=home, GF=vgoal, GA=hgoal)
    ) #rbind two copies of the orignal df, simply reversing home/away team for each match

  temp1<-
    temp %>%
    mutate(GD = GF-GA) %>%
    group_by(team) %>%
    summarize(GP = n(),
              W = sum(GD>0),
              D = sum(GD==0),
              L = sum(GD<0),
              gf = sum(GF),
              ga = sum(GA),
              gd = sum(GD)
    ) %>%
    mutate(Pts = (W*points) + D) %>%
    arrange(desc(Pts), desc(gd), desc(gf))

  return(temp1)
}
