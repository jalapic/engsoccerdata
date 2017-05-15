#' Make an English league table
#'
#' @param df The results dataframe
#' @param Season The Season
#' @param tier The tier - must be included
#' @param division The division
#' @param penalties Whether to account for points penalties
#' @section Notes:
#' This table makes league tables according to the points and tie-breaking procedures
#' that were in place for each league in each year
#' @return a dataframe with a league table
#' @importFrom magrittr "%>%"
#' @examples
#' maketable_eng(df=england,Season=1920,tier=1)
#' maketable_eng(df=england,Season=1947,division="3a",tier=3)
#' maketable_eng(df=england,Season=1975,tier=1)
#' maketable_eng(df=england,Season=1975,tier=2)
#' maketable_eng(df=england,Season=2007,tier=3, penalties=TRUE)
#' @export


maketable_eng <- function(df=NULL, Season=NULL, tier=NULL, division=NULL, penalties=FALSE){

  newPts<-penalty<-GA<-GF<-ga<-gf<-gd<-GD<-W<-Pts<-.<-Date<-home<-team<-visitor<-hgoal<-opp<-vgoal<-goaldif <-FT<-result<-maxgoal<-mingoal<-absgoaldif<-NULL

  deductions <- engsoccerdata::deductions

  if(!is.null(division)){ df <-  df[df$division==division,] }

  #1981/82 - three points for a win introduced.
  if(Season>=1981){

    xx <- maketable(df,Season,tier,pts=3)

    if(any(xx$team %in% deductions$team & Season %in% deductions$Season)==T && penalties==T){

      penalty <- deductions[deductions$team %in% xx$team & deductions$Season %in% Season,]
      # need if penalties has no rows ... just return xx

      if(nrow(penalty)>0){
        penalty$newPts <- xx$Pts[match(penalty$team,xx$team)]-penalty$deduction
        newPts <- penalty$newPts[match(xx$team,penalty$team)]
        xx$Pts <- ifelse(!is.na(newPts), newPts, xx$Pts)

        # rearrange by same rules as before...
        xx %>%
          dplyr::arrange(-Pts, -gd, -gf) %>%
          dplyr::mutate(Pos = rownames(.)) %>%
          as.data.frame() -> xx
      }

    }


  } else


    #1976/77 - 1980/81 goal difference used in all tiers
    if(Season>=1976 & Season<1981){
      xx <- maketable(df,Season,tier,pts=2)
    } else


      #1974/75 and before goal average.- the number of goals scored divided by the number of goals conceded
      if(Season<=1974){
        xx <- maketable(df,Season,tier,pts=2)
        xx <- xx %>% dplyr::mutate(gd=gf/ga) %>% dplyr::arrange(-Pts,-gd,-gf) %>% dplyr::mutate(Pos=1:nrow(xx))


        if(any(xx$team %in% deductions$team & Season %in% deductions$Season)==T && penalties==T){


          penalty <- deductions[deductions$team %in% xx$team & deductions$Season %in% Season,]
          # need if penalties has no rows ... just return xx

          if(nrow(penalty)>0){
            penalty$newPts <- xx$Pts[match(penalty$team,xx$team)]-penalty$deduction
            newPts <- penalty$newPts[match(xx$team,penalty$team)]
            xx$Pts <- ifelse(!is.na(newPts), newPts, xx$Pts)

            # rearrange by same rules as before...
            xx %>%
              dplyr::arrange(-Pts,-gd,-gf) %>%
              dplyr::mutate(Pos=1:nrow(xx)) %>%
              as.data.frame() -> xx
          }
        }
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
