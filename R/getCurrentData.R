#' Get current season data
#'
#' @param df the results dataset
#' @param division division to add
#' @param tier tier to add
#' @param Season Season to get current data for
#' @return a dataframe with results for current season including half-time and second-half data
#' @importFrom utils "read.csv"
#' @export

getCurrentData <- function(df, division, tier, Season){

  if(Season > 2017){
    data.frame(
      "Date" = as.character(as.Date(df$Date, "%d/%m/%Y")),
      "Season" = Season,
      "home" = as.character(df$HomeTeam),
      "visitor" = as.character(df$AwayTeam),
      "HT" = paste0(df$HTHG, "-", df$HTAG),
      "FT" = paste0(df$FTHG, "-", df$FTAG),
      "hgoal" = df$FTHG,
      "vgoal" = df$FTAG,
      "ht_hgoal" = as.numeric(df$HTHG),
      "ht_vgoal" = as.numeric(df$HTAG),
      "h2_hgoal" = as.numeric(df$FTHG) - as.numeric(df$HTHG),
      "h2_vgoal" = as.numeric(df$FTAG) - as.numeric(df$HTAG),
      "division" = division,
      "tier" = tier,
      "totgoal" = df$FTHG + df$FTAG,
      "goaldif" = df$FTHG - df$FTAG,
      "result" = as.character(ifelse(df$FTHG > df$FTAG, "H",
                                     ifelse(df$FTHG < df$FTAG, "A", "D"))),
      stringsAsFactors = FALSE
    )
  } else {
    data.frame(
      "Date" = as.character(as.Date(df$Date, "%d/%m/%y")),
      "Season" = Season,
      "home" = as.character(df$HomeTeam),
      "visitor" = as.character(df$AwayTeam),
      "HT" = paste0(df$HTHG, "-", df$HTAG),
      "FT" = paste0(df$FTHG, "-", df$FTAG),
      "hgoal" = df$FTHG,
      "vgoal" = df$FTAG,
      "ht_hgoal" = as.numeric(df$HTHG),
      "ht_vgoal" = as.numeric(df$HTAG),
      "h2_hgoal" = as.numeric(df$FTHG) - as.numeric(df$HTHG),
      "h2_vgoal" = as.numeric(df$FTAG) - as.numeric(df$HTAG),
      "division" = division,
      "tier" = tier,
      "totgoal" = df$FTHG + df$FTAG,
      "goaldif" = df$FTHG - df$FTAG,
      "result" = as.character(ifelse(df$FTHG > df$FTAG, "H",
                                     ifelse(df$FTHG < df$FTAG, "A", "D"))),
      stringsAsFactors = FALSE
    )
  }
}
