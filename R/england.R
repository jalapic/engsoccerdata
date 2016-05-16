#' English league results 1888-2016
#'
#' All results for English soccer games in the top 4 tiers
#' from 1888/89 season to 2015/16 season.  For playoff games
#' see separate dataset `englandplayoffs`
#'
#' @format A data frame with 192004 rows and 12 variables:
#' \describe{
#'   \item{Date}{Date of match}
#'   \item{Season}{Season of match - refers to starting year}
#'   \item{home}{Home team}
#'   \item{visitor}{Visiting team}
#'   \item{FT}{Full-time result}
#'   \item{hgoal}{Goals scored by home team}
#'   \item{vgoal}{Goals scored by visiting team}
#'   \item{division}{Division: 1,2,3,4 or 3a (Old 3-North) or 3b (Old 3-South)}
#'   \item{tier}{Tier of football pyramid: 1,2,3,4}
#'   \item{totgoal}{Total goals in game}
#'   \item{goaldif}{Goal difference in game home goals - visitor goals}
#'   \item{result}{Result: H-Home Win, A-Away Win, D-Draw}
#' }
"england"
