#' English club data
#'
#' additional data for english clubs (locations, colours, names)
#' for teams in the engsoccerdata dataset
#' currently beta and needs filling in
#'
#' @format A data frame with 401 rows and 9 variables:
#' \describe{
#'   \item{team}{the name of the team in the matches dataset}
#'   \item{lat}{the latitude of the teams ground (beta- drawn from the locations file)}
#'   \item{lon}{the longitude of the teams ground (beta- drawn from the locations file)}
#'   \item{highest_div}{the highest division (tier) the team reaches in the matches dataset}
#'   \item{col1}{primary team colour}
#'   \item{col2}{secondary team colour}
#'   \item{short_name}{an abbreviated name for the team in case of long names}
#'   \item{three_letter_name}{a 3 letter code for the team (not added)}
#'   \item{nicknames}{a list of nicknames for the team (not added- see team names file)}
#' }
"england_club_data"
