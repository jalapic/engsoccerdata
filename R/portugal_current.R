#' Get current Portugal season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @importFrom utils "read.csv"
#' @examples
#' portugal_current()
#' @export


portugal_current <- function(){

p1<-df1<-NULL

p1=read.csv("http://www.football-data.co.uk/mmz4281/1617/P1.csv")
df1 <- rbind(engsoccerdata::getCurrentData(p1,'P1',1))
df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
port <- engsoccerdata::portugal
if(identical(max(df1$Date), max(port$Date))) warning("The returned dataframe contains data already included in 'portugal' dataframe")
tm <- engsoccerdata::teamnames
df1$home <- tm$name[match(df1$home,tm$name_other)]
df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
return(df1)
}
