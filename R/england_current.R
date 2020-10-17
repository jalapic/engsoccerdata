#' Get current England season data for all tiers
#'
#' @return a dataframe with results for current
#' season for all top four divisions
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' england_current()
#' @export

england_current <- function(Season = 2020){

  s1 <- s2 <- myseason <- tm <- df1 <- df <- . <- Date <- tier <- home <- visitor <- hgoal <- vgoal <- goaldif <- FT <- division <- result <- name <- name_other <- most_recent <- country <- NULL

  myseason <- Season
  s2 <- as.numeric(substr(myseason, 3, 4))
  s1 <- s2 + 1

  df <- rbind(read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E0.csv")),
              read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E1.csv")),
              read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E2.csv")),
              read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E3.csv"))
  )

  df <- df[1:8]
  df$Date <- as.Date(df$Date, "%d/%m/%y")


df1 <- data.frame(Date = df$Date,
                  Season = myseason,
                  home = as.character(df$HomeTeam),
                  visitor = as.character(df$AwayTeam),
                  FT = paste0(df$FTHG,"-", df$FTAG),
                  hgoal = df$FTHG,
                  vgoal = df$FTAG,
                  division = as.numeric(factor(df$Div)),
                  tier = as.numeric(factor(df$Div)),
                  totgoal = df$FTHG + df$FTAG,
                  goaldif = df$FTHG - df$FTAG,
                  result = as.character(df$FTR)
)

i <- sapply(df1, is.factor)
df1[i] <- lapply(df1[i], as.character)
df1$Date <- as.character(df1$Date)

#fix teamnames
df1$home <- as.character(teamnames$name[match(df1$home, teamnames$name_other)])
df1$visitor <- as.character(teamnames$name[match(df1$visitor, teamnames$name_other)])


return(df1)
}
