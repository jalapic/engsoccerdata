#' Belgian league results 1995-2022
#'
#' All results for Belgian soccer games in the top tier
#' from 1995/96 season to 2021/22 season.  Doesn't include
#' playoff games.
#'
#' @format A data frame with 7464 rows and 12 variables:
#' \describe{
#'   \item{Date}{Date of match}
#'   \item{Season}{Season of match - refers to starting year}
#'   \item{home}{Home team}
#'   \item{visitor}{Visiting team}
#'   \item{FT}{Full-time result}
#'   \item{hgoal}{Goals scored by home team}
#'   \item{vgoal}{Goals scored by visiting team}
#'   \item{division}{Division}
#'   \item{tier}{Tier of football pyramid: 1}
#'   \item{totgoal}{Total goals in game}
#'   \item{goaldif}{Goal difference in game home goals - visitor goals}
#'   \item{result}{Result: H-Home Win, A-Away Win, D-Draw}
#' }
"belgium"
