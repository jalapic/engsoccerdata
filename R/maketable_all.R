#' Make a league table - not limited by seasons or tiers
#'
#' @param df The results dataframe
#' @param Season The Season
#' @param tier The tier
#' @param pts Points for a win. Default is 3.
#' @param begin Earliest date of results to make table from (format Y-m-d)
#' @param end Latest date of results to make table from (format Y-m-d)
#' @param type Whether to show all results together or only home or away results.
#' @section Notes:
#' The table that is produced is based upon 3 points for a win (unless otherwise
#'     defined), 1 for a draw and 0 for a loss.  The table is sorted based upon descending
#'     GD and then descending GF as tie-breakers. Use other 'maketable' functions for
#'     more precise tables for each league.
#' @return a dataframe with a league table
#' @importFrom magrittr "%>%"
#' @examples
#' maketable_all(df=england[england$tier==1,],begin="1992-08-15",
#'      end="2017-07-01") #EPL historical table
#' maketable_all(df=england[england$tier==1,],begin="1992-08-15",
#'      end="2017-07-01", type="away") #EPL historical table away results
#' @export


maketable_all <- function(df=NULL, Season=NULL, tier=NULL, pts=3, begin=NULL, end=NULL, type = c("both", "home", "away")){

  GA<-GF<-ga<-gf<-gd<-GD<-D<-L<-W<-Pts<-.<-Date<-home<-team<-visitor<-hgoal<-opp<-vgoal<-goaldif <-FT<-division<-result<-maxgoal<-mingoal<-absgoaldif<-NULL

    #season/tier
    if(!is.null(Season) & is.null(tier)) {
      dfx <- df[(df$Season == Season), ]
    } else if(is.null(Season) & !is.null(tier)) {
      dfx <- df[(df$tier == tier), ]
    } else if(!is.null(Season) & !is.null(tier)) {
      dfx <- df[(df$Season == Season & df$tier == tier), ]
    } else {
      dfx <- df
    }

    #dates
    if(!is.null(begin) & is.null(end)) {
      dfx <- dfx[(dfx$Date >= begin & dfx$Date <= end), ]
    } else if(is.null(begin) & !is.null(end)) {
      dfx <- dfx[(dfx$Date <= end), ]
    } else if(!is.null(begin) & !is.null(end)) {
      dfx <- dfx[(dfx$Date >= begin), ]
    }


  #subset only home or away fixtures, if applicable
  if(match.arg(type)=="home") {
    temp <- dplyr::select(dfx, team=home, opp=visitor, GF=hgoal, GA=vgoal)
  } else if(match.arg(type)=="away") {
    temp <- dplyr::select(dfx, team=visitor, opp=home, GF=vgoal, GA=hgoal)
  } else if(match.arg(type)=="both") {
    temp <-rbind(
      dplyr::select(dfx, team=home, opp=visitor, GF=hgoal, GA=vgoal),
      dplyr::select(dfx, team=visitor, opp=home, GF=vgoal, GA=hgoal)
    )
  }

    temp  %>%
      dplyr::mutate(GD = GF - GA) %>%
      dplyr::group_by(team) %>%
      dplyr::summarise(GP = sum(GD <= 100), W = sum(GD > 0), D = sum(GD == 0), L = sum(GD < 0), gf = sum(GF), ga = sum(GA), gd = sum(GD)) %>%
      dplyr::mutate(Pts = (W * pts) + D) %>%
      dplyr::arrange(-Pts, -gd, -gf) %>%
      dplyr::mutate(Pos = rownames(.)) %>%
      as.data.frame() -> temp

    return(temp)
  }

