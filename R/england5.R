#' English league results 1979-2016
#'
#' All results for English soccer games in the 5th tier
#' from 1979/80 season to 2016/17 season.  For playoff games
#' see separate dataset `englandplayoffs`. Note dates of games
#' are only available for the 1999/2000 season onwards.
#'
#' @format A data frame with 18294 rows and 12 variables:
#' \describe{
#'   \item{Date}{Date of match}
#'   \item{Season}{Season of match - refers to starting year}
#'   \item{home}{Home team}
#'   \item{visitor}{Visiting team}
#'   \item{FT}{Full-time result}
#'   \item{hgoal}{Goals scored by home team}
#'   \item{vgoal}{Goals scored by visiting team}
#'   \item{division}{Division: 5}
#'   \item{tier}{Tier of football pyramid: 5}
#'   \item{totgoal}{Total goals in game}
#'   \item{goaldif}{Goal difference in game home goals - visitor goals}
#'   \item{result}{Result: H-Home Win, A-Away Win, D-Draw}
#' }
"england5"
