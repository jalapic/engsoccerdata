#' Get current Italy season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @importFrom utils "read.csv"
#' @examples
#' italy_current()
#' @export


italy_current <- function(){

i1<-i2<-df1<-NULL

i1=read.csv("http://www.football-data.co.uk/mmz4281/1617/I1.csv")
#i2=read.csv("http://www.football-data.co.uk/mmz4281/1617/I2.csv")
#df1 <- rbind(engsoccerdata::getCurrentData(i1,'I1',1),engsoccerdata::getCurrentData(i2,'I2',2))
df1 <- rbind(engsoccerdata::getCurrentData(i1,'I1',1))
df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
ital <- engsoccerdata::italy
if(identical(max(df1$Date), max(ital$Date))) warning("The returned dataframe contains data already included in 'italy' dataframe")
tm <- engsoccerdata::teamnames
df1$home <- tm$name[match(df1$home,tm$name_other)]
df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
df1 <- df1[c(1:7,9)]
return(df1)
}

