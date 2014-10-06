#' Return all instances of a team being involved in a game with n goals
#'
#' @examples
#' df <- engsoccerdata2
#' totalgoals_by_team(df, 10, "York City")
#' totalgoals_by_team(df, 10, "Manchester United")
#' totalgoals_by_team(df, 12, "Aston Villa")
#'
#' @export
totalgoals_by_team<-function (df, goals, teamname) {

  df %>%
    filter(totgoal >= goals, home == teamname | visitor == teamname) %>%
    select(Date, Season,home,visitor,FT, totgoal, division,tier) %>%
    arrange(desc(totgoal), Season)
}
