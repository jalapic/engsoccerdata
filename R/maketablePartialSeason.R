#' Make a league table
#'
#' @param df The results dataframe
#' @param Season The Season
#' @param tier The tier
#' @param pts Points for a win. Default is 3.
#' @section Notes:
#' The table that is produced is based upon 3 points for a win (unless otherwise
#' defined), 1 for a draw and 0 for a loss.  The table is sorted based upon descending
#' GD and then descending GF as tie-breakers. Different leagues have had different
#' methods for tie-breaks over the years. This league table is a simple generic one.
#' It also does not evaluate points deducted from teams or if games were  artificially
#' awarded to one side based on games not being played.
#' @return a dataframe with a league table
#' @importFrom magrittr "%>%"
#' @examples
#' maketable(df=england,Season=2013,tier=1,pts=3)
#' @export


maketablePartialSeason <- function(df=NULL,
                                   Season=NULL,
                                   tier=NULL, enddate=NULL, pts=3){

  GA<-GF<-ga<-gf<-gd<-GD<-D<-L<-W<-Pts<-.<-Date<-home<-team<-visitor<-hgoal<-opp<-vgoal<-goaldif <-FT<-division<-result<-maxgoal<-mingoal<-absgoaldif<-NULL

  dfx <- df[(df$Season==Season & df$tier==tier),]
  
  if (!is.null(enddate)) {
      print(enddate)
      dfx <- dfx %>% group_by(Season) %>% mutate(firstdate = min(as.Date(Date)), currentdate = as.integer(as.Date(Date) - as.Date(firstdate))) %>% filter(currentdate<=enddate) %>% ungroup()
  }
  
  temp <- rbind(
      dfx %>%
        dplyr::select(team=home, opp=visitor, GF=hgoal, GA=vgoal),
      dfx %>%
        dplyr::select(team=visitor, opp=home, GF=vgoal, GA=hgoal)
    ) %>%

    dplyr::mutate(GD = GF-GA) %>%
    dplyr::group_by(team) %>%
    dplyr::summarise(GP = sum(GD<=100),
              W = sum(GD>0),
              D = sum(GD==0),
              L = sum(GD<0),
              gf = sum(GF),
              ga = sum(GA),
              gd = sum(GD)
    ) %>%
    dplyr::mutate(Pts = (W*pts) + D) %>%
    dplyr::arrange(-Pts, -gd, -gf) %>%
    dplyr::mutate(Pos = rownames(.)) %>%
    as.data.frame()

  return(temp)
}



