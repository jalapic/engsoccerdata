#' Get current Belgium season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @importFrom utils "read.csv"
#' @examples
#' belgium_current()
#' @export


belgium_current <- function(){

b1<-df1<-NULL

b1=read.csv("http://www.football-data.co.uk/mmz4281/1617/B1.csv")
df1 <- rbind(engsoccerdata::getCurrentData(b1,'B1',1))
df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
belg <- engsoccerdata::belgium
if(identical(max(df1$Date), max(belg$Date))) warning("The returned dataframe contains data already included in 'belgium' dataframe")
tm <- engsoccerdata::teamnames
df1$home <- tm$name[match(df1$home,tm$name_other)]
df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
return(df1)
}
