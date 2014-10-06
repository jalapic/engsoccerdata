#' Function to List the summary stats of all games ever between two teams
#'
#' @examples
#' games_between.summary(df, "Exeter City", "York City")
#' games_between.summary(df, "Aston Villa", "York City")
#' games_between.summary(df, "Manchester United", "Liverpool")
#' games_between.summary(df, "Aston Villa", "Everton")
#' games_between.summary(df, "Sheffield Wednesday", "Sheffield United")
#' games_between.summary(df, "Queens Park Rangers", "Fulham")
#'
#' @export
games_between.summary<-function (df, teamname1, teamname2) {


  df %>%
    group_by(home) %>%
    filter(home==teamname1 & visitor==teamname2 | home==teamname2 & visitor==teamname1)%>%
    summarise(P = n(), GF = sum(hgoal), GA = sum(vgoal), GD=sum(goaldif),
              W=sum(result=="H"), D=sum(result=="D"), L=sum(result=="A") )
}
