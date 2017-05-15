#' Get current Greece season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @importFrom utils "read.csv"
#' @examples
#' greece_current()
#' @export


greece_current <- function(){

g1<-df1<-NULL

g1=read.csv("http://www.football-data.co.uk/mmz4281/1617/G1.csv")
df1 <- rbind(engsoccerdata::getCurrentData(g1,'G1',1))
df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
gree <- engsoccerdata::greece
if(identical(max(df1$Date), max(gree$Date))) warning("The returned dataframe contains data already included in 'greece' dataframe")
tm <- engsoccerdata::teamnames
df1$home <- tm$name[match(df1$home,tm$name_other)]
df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
return(df1)
}
