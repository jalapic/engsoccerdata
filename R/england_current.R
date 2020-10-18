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

  library(tidyverse)
  library(rvest)

  url1 <- "https://www.11v11.com/competitions/premier-league/2021/matches/"
  url2 <- "https://www.11v11.com/competitions/league-championship/2021/matches/"
  url3 <- "https://www.11v11.com/competitions/league-one/2021/matches/"
  url4 <- "https://www.11v11.com/competitions/league-two/2021/matches/"

  x1 <- read_html(url1) %>% html_table(fill = TRUE)
  x2 <- read_html(url2) %>% html_table(fill = TRUE)
  x3 <- read_html(url3) %>% html_table(fill = TRUE)
  x4 <- read_html(url4) %>% html_table(fill = TRUE)

  make_data <- function(x){
    x <- x[[1]][,1:4]
    x <-x[grepl("([0-9]+).*$", x[,1]),]#get rid of months text
    colnames(x)<-c("Date","home","FT","visitor")
    x$Date <- as.character(as.Date(x$Date, format="%d %b %Y"))
    x$Season <- as.numeric(Season)
    x$FT <- gsub(":", "-", x$FT)
    x <- x[nchar(x$FT)>1,]
    hgvg <- matrix(unlist(strsplit(x$FT, "-")), ncol=2, byrow = T)
    x$hgoal <- as.numeric(hgvg[,1])
    x$vgoal <- as.numeric(hgvg[,2])
    x$totgoal <- x$hgoal+x$vgoal
    x$goaldif <- x$hgoal-x$vgoal
    x$result <- ifelse(x$hgoal>x$vgoal, "H", ifelse(x$hgoal<x$vgoal, "A", "D"))
    return(x)
  }

  x1d <- make_data(x1)
  x2d <- make_data(x2)
  x3d <- make_data(x3)
  x4d <- make_data(x4)

  x1d$division <- 1
  x1d$tier <- 1
  x2d$division <- 2
  x2d$tier <- 2
  x3d$division <- 3
  x3d$tier <- 3
  x4d$division <- 4
  x4d$tier <- 4

  xd <- rbind(x1d,x2d,x3d,x4d)
  xd <- xd[colnames(england)]

  xd %>%
    mutate(home = case_when(
      grepl("Brighton and Hove", home) ~ "Brighton & Hove Albion",
      grepl("Cheltenham Town", home) ~ "Cheltenham",
      grepl("Stevenage", home) ~ "Stevenage Borough",
      grepl("Harrogate Town", home) ~ "Harrogate Town A.F.C.",
      grepl("Macclesfield Town", home) ~ "Macclesfield",
      grepl("Yeovil", home) ~ "Yeovil",
      TRUE ~ home
    )) %>%
    mutate(visitor = case_when(
      grepl("Brighton and Hove", visitor) ~ "Brighton & Hove Albion",
      grepl("Cheltenham Town", visitor) ~ "Cheltenham",
      grepl("Stevenage", visitor) ~ "Stevenage Borough",
      grepl("Macclesfield Town", visitor) ~ "Macclesfield",
      grepl("Harrogate Town", visitor) ~ "Harrogate Town A.F.C.",
      grepl("Yeovil", visitor) ~ "Yeovil",
      TRUE ~ visitor
    )) -> xd

  return(xd)




## this is a nightmare with the teamnames Tranmere, Forest Green Rovers, Harrogate, Salford, Lincoln

#   s1 <- s2 <- myseason <- tm <- df1 <- df <- . <- Date <- tier <- home <- visitor <- hgoal <- vgoal <- goaldif <- FT <- division <- result <- name <- name_other <- most_recent <- country <- NULL
#
#   myseason <- Season
#   s2 <- as.numeric(substr(myseason, 3, 4))
#   s1 <- s2 + 1
#
#   df <- rbind(read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E0.csv")),
#               read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E1.csv")),
#               read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E2.csv")),
#               read.csv(paste0("http://www.football-data.co.uk/mmz4281/ ", s2, s1, "/E3.csv"))
#   )
#
#   df <- df[1:8]
#   df$Date <- as.Date(df$Date, "%d/%m/%y")
#
#
# df1 <- data.frame(Date = df$Date,
#                   Season = myseason,
#                   home = as.character(df$HomeTeam),
#                   visitor = as.character(df$AwayTeam),
#                   FT = paste0(df$FTHG,"-", df$FTAG),
#                   hgoal = df$FTHG,
#                   vgoal = df$FTAG,
#                   division = as.numeric(factor(df$Div)),
#                   tier = as.numeric(factor(df$Div)),
#                   totgoal = df$FTHG + df$FTAG,
#                   goaldif = df$FTHG - df$FTAG,
#                   result = as.character(df$FTR)
# )
#
# i <- sapply(df1, is.factor)
# df1[i] <- lapply(df1[i], as.character)
# df1$Date <- as.character(df1$Date)
#
# #fix teamnames
# df1$home <- as.character(as.character(teamnames$name)[match(as.character(df1$home), as.character(teamnames$name_other))])
# df1$visitor <- as.character(as.character(teamnames$name)[match(as.character(df1$visitor), as.character(teamnames$name_other))])
#
# return(df1)
}
