#' Get current France season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @importFrom utils "read.csv"
#' @examples
#' france_current()
#' @export


france_current <- function(){

  f1<-f2<-df1<-NULL
  f1=read.csv("http://www.football-data.co.uk/mmz4281/1617/F1.csv")
  #f2=read.csv("http://www.football-data.co.uk/mmz4281/1617/F2.csv")
  #df1 <- rbind(engsoccerdata::getCurrentData(f1,'F1',1),engsoccerdata::getCurrentData(f2,'F2',2))
  df1 <- rbind(engsoccerdata::getCurrentData(f1,'F1',1))
  df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
  fran <- engsoccerdata::france
  if(identical(max(df1$Date), max(fran$Date))) warning("The returned dataframe contains data already included in 'france' dataframe")
  tm <- engsoccerdata::teamnames
  df1$home <- tm$name[match(df1$home,tm$name_other)]
  df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
  return(df1)
  }

