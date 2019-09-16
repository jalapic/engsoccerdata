#' English football ground locations 1880-2019
#'
#' dataset of ground locations for various English
#' football teams and neutral grounds for matches
#' in the engsoccerdata package
#'
#' @format A data frame with 194040 rows and 12 variables:
#' \describe{
#'   \item{location}{the identifier of the location, e.g. a team name}
#'   \item{lat}{the latitude coordinate of the data}
#'   \item{lon}{the longitude coordinate of the data}
#'   \item{geometry}{the geometry of the latitude and longitude}
#'   \item{type}{the type of data described- whether a stadium name, or a football team name}
#' }
"england_locations"
