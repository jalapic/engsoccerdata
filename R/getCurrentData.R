#' Get current season data
#'
#' @param df the results dataset
#' @param division division to add
#' @param tier tier to add
#' @param Season Season to get current data for
#' @return a dataframe with results for current season
#' @importFrom utils "read.csv"
#' @export

getCurrentData <- function(df,division,tier,Season){
  data.frame("Date" = as.character(as.Date(df$Date, "%d/%m/%y")),
             "Season" = Season,
             "home" = as.character(df$HomeTeam),
             "visitor" = as.character(df$AwayTeam),
             "FT" = paste0(df$FTHG, "-", df$FTAG),
             "hgoal" = df$FTHG,
             "vgoal" = df$FTAG,
             "division" = division,
             "tier" = tier,
             "totgoal" = df$FTHG + df$FTAG,
             "goaldif" = df$FTHG - df$FTAG,
             "result" = as.character(ifelse(df$FTHG > df$FTAG, "H",
                                            ifelse(df$FTHG < df$FTAG, "A", "D")))
             , stringsAsFactors = FALSE)
}
