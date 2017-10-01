#' Get current Spain season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' spain_current()
#' @export

spain_current <- function(Season=2017){

    s1<-s2<-myseason<-sp1<-df1<-NULL
    myseason<-Season
    s2<-as.numeric(substr(myseason,3,4))
    s1 <- s2+1

  sp1=read.csv(paste0("http://www.football-data.co.uk/mmz4281/",s2,s1,"/SP1.csv"))
  df1 <- rbind(engsoccerdata::getCurrentData(sp1,'SP1',1,Season=myseason))
  df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
  spai <- engsoccerdata::spain
  if(identical(max(df1$Date), max(spai$Date))) warning("The returned dataframe contains data already included in 'spain' dataframe")
  tm <- engsoccerdata::teamnames
  df1$home <- tm$name[match(df1$home,tm$name_other)]
  df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
  df1 <- df1[c(1:7,9)]
  df1$round <- "league"
  df1$notes<-df1$group<-NA
  df1$HT <- NA
  df1 <- df1[c(1:4,12,5:11)]
  return(df1)
  }
