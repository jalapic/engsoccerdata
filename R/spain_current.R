#' Get current Spain season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @importFrom utils "read.csv"
#' @examples
#' spain_current()
#' @export


spain_current <- function(){

  sp1<-df1<-NULL
  sp1=read.csv("http://www.football-data.co.uk/mmz4281/1617/SP1.csv")
  df1 <- rbind(engsoccerdata::getCurrentData(sp1,'SP1',1))
  df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
  spai <- engsoccerdata::spain
  if(identical(max(df1$Date), max(spai$Date))) warning("The returned dataframe contains data already included in 'spain' dataframe")
  tm <- engsoccerdata::teamnames
  df1$home <- tm$name[match(df1$home,tm$name_other)]
  df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
  df1 <- df1[c(1:7,9)]
  df1$round <- "league"
  df1$group<-df1$notes<-NA
  return(df1)
  }
