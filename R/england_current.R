#' Get current England season data for all tiers
#'
#' @return a dataframe with results for current
#' season for all top four divisions
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' england_current()
#' @export

england_current <-  function(Season=2018){
  d <- england_current2(england_current1(Season=Season))
  return(d)
}

england_current1 <- function(Season = 2018){

  #this function is completely  bonkers because of a weird thing with Forest Green / Lincoln  City ....

  s1 <- s2 <- myseason <- tm <- df1 <- df <- . <- Date <- tier <- home <- visitor <- hgoal <- vgoal <- goaldif <- FT <- division <- result <- name <- name_other <- most_recent <- country <- NULL

  myseason <- Season
  s2 <- as.numeric(substr(myseason, 3, 4))
  s1 <- s2 + 1

  df <- rbind(read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E0.csv")),
              read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E1.csv")),
              read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E2.csv")),
              read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E3.csv"))
  )

  if(myseason >= 2018) {
    df$Date <- as.Date(df$Date, "%d/%m/%Y")
  } else {
    df$Date <- as.Date(df$Date, "%d/%m/%y")
  }
  
  engl <- engsoccerdata::england
  if (identical(max(as.Date(df$Date, "%d/%m/%y")), max(engl$Date)))
    warning("The returned dataframe contains data already included in 'england' dataframe")

  df1 <- data.frame(Date = df$Date,
                    Season = myseason, home = as.character(df$HomeTeam),
                    visitor = as.character(df$AwayTeam), FT = paste0(df$FTHG,
                                                                     "-", df$FTAG), hgoal = df$FTHG, vgoal = df$FTAG,
                    division = as.numeric(factor(df$Div)), tier = as.numeric(factor(df$Div)),
                    totgoal = df$FTHG + df$FTAG, goaldif = df$FTHG - df$FTAG,
                    result = as.character(ifelse(df$FTHG > df$FTAG, "H",
                                                 ifelse(df$FTHG < df$FTAG, "A", "D"))))
  return(df1)
}

england_current2 <- function(df1) {


  weird_names <- c("Forest Green", "Lincoln")

  tm <- teamnames[teamnames$name != "Accrington F.C.", ]
  df1$home <- ifelse(!df1$home %in% weird_names, as.character(tm$name[match(df1$home, tm$name_other)]), as.character(df1$home))
  df1$visitor <- ifelse(!df1$visitor %in% weird_names, as.character(tm$name[match(df1$visitor, tm$name_other)]), as.character(df1$visitor))

  df1$home[df1$home=="Forest Green"] <- "Forest Green Rovers"
  df1$visitor[df1$visitor=="Forest Green"] <- "Forest Green Rovers"
  df1$home[df1$home=="Lincoln"] <- "Lincoln City"
  df1$visitor[df1$visitor=="Lincoln"] <- "Lincoln City"

  # tm <- teamnames[teamnames$name != "Accrington F.C.", ]
  # df1$home <- tm$name[match(df1$home, tm$name_other)]
  # df1$visitor <- tm$name[match(df1$visitor, tm$name_other)]

  return(df1)
}


