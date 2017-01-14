#' Get current England season data for all tiers
#'
#' @return a dataframe with results for current
#' season for all top four divisions
#' @importFrom utils "read.csv"
#' @examples
#' england_current()
#' @export


england_current <- function(){

  tm<-df1<-df<-.<-Date<-tier<-home<-visitor<-hgoal<-vgoal<-goaldif<-FT<-Season<-division<-result<-name<-name_other<-most_recent<-country<-NULL

  df <- rbind(read.csv("http://www.football-data.co.uk/mmz4281/1617/E0.csv"),
              read.csv("http://www.football-data.co.uk/mmz4281/1617/E1.csv"),
              read.csv("http://www.football-data.co.uk/mmz4281/1617/E2.csv"),
              read.csv("http://www.football-data.co.uk/mmz4281/1617/E3.csv")
  )

  df1 <-  data.frame("Date" = as.character(as.Date(df$Date, "%d/%m/%y")),
                     "Season" = 2016,
                     "home" = as.character(df$HomeTeam),
                     "visitor" = as.character(df$AwayTeam),
                     "FT" = paste0(df$FTHG, "-", df$FTAG),
                     "hgoal" = df$FTHG,
                     "vgoal" = df$FTAG,
                     "division" = as.numeric(df$Div),
                     "tier" = as.numeric(df$Div),
                     "totgoal" = df$FTHG + df$FTAG,
                     "goaldif" = df$FTHG - df$FTAG,
                     "result" = as.character(ifelse(df$FTHG > df$FTAG, "H",
                                                    ifelse(df$FTHG < df$FTAG, "A", "D")))
                     , stringsAsFactors = FALSE)

  tm <- teamnames[teamnames$name!="Accrington F.C.",]
  df1$home <- tm$name[match(df1$home,tm$name_other)]
  df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
  return(df1)

}
