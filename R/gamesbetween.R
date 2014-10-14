#' Function to List all games ever between two teams
#'
#' @param df df
#' @param teamname1 teamname1
#' @param teamname2 teamname2
#'
#' @examples
#' df <- engsoccerdata2
#' games_between(df, "Aston Villa", "York City")
#' games_between(df, "Carlisle United", "Chelsea")
#' games_between(df, "Manchester United", "Milton Keynes Dons") #will give 0 rows as never played
#'
#' @export
games_between<-function (df, teamname1, teamname2) {

  df %>%
    filter(home==teamname1 & visitor==teamname2 | home==teamname2 & visitor==teamname1)%>%
    select(Date,Season,home,visitor,FT,division,tier) %>%
    arrange(Season)

}
