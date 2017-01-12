#' Make an English league table
#'
#' @param df The results dataframe
#' @param Season The Season
#' @param tier The tier - must be included
#' @param division The division
#' @section Notes:
#' This table makes league tables according to the points and tie-breaking procedures
#' that were in place for each league in each year
#' It also does not evaluate points deducted from teams or if games were  artificially
#' awarded to one side based on games not being played.
#' @return a dataframe with a league table
#' @importFrom magrittr "%>%"
#' @examples
#' maketable_eng(df=england,Season=1920,tier=1)
#' maketable_eng(df=england,Season=1947,division="3a",tier=3)
#' maketable_eng(df=england,Season=1975,tier=1)
#' maketable_eng(df=england,Season=1975,tier=2)
#' maketable_eng(df=england,Season=1981,tier=1)
#' @export


maketable_eng <- function(df=NULL, Season=NULL, tier=NULL, division=NULL){

  GA<-GF<-ga<-gf<-gd<-GD<-W<-Pts<-.<-Date<-home<-team<-visitor<-hgoal<-opp<-vgoal<-goaldif <-FT<-division<-result<-maxgoal<-mingoal<-absgoaldif<-NULL

  if(!is.null(division)){ df <-  df[df$division==division,] }

  #1981/82 - three points for a win introduced.
  if(Season>=1981){
    xx <- maketable(df,Season,tier,pts=3)
} else


  #1976/77 - 1980/81 goal difference used in all tiers
  if(Season>=1976 & Season<=1981){
    xx <- maketable(df,Season,tier,pts=2)

  } else


  #1974/75 and before goal average.- the number of goals scored divided by the number of goals conceded
    if(Season<=1974){
      xx <- maketable(df,Season,tier,pts=2)
      xx <- xx %>% dplyr::mutate(gd=gf/ga) %>% dplyr::arrange(-Pts,-gd,-gf) %>% dplyr::mutate(Pos=1:nrow(xx))
  }  else


    if(Season==1975 & tier>1){
      xx <- maketable(df,Season,tier,pts=2)
      xx <- xx %>% dplyr::mutate(gd=gf/ga) %>% dplyr::arrange(-Pts,-gd,-gf) %>% dplyr::mutate(Pos=1:nrow(xx))
    }  else


    if(Season==1975 & tier==1){
        xx <- maketable(df,Season,tier,pts=2)

    }
 return(xx)
}
