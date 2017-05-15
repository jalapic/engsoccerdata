#' Get current Germany season data for all tiers
#'
#' @return a dataframe with results for current
#' season for top two divisions
#' @importFrom utils "read.csv"
#' @examples
#' germany_current()
#' @export


germany_current <- function(){

b1<-b2<-df1<-NULL

b1=read.csv("http://www.football-data.co.uk/mmz4281/1617/D1.csv")
b2=read.csv("http://www.football-data.co.uk/mmz4281/1617/D2.csv")
df1 <- rbind(engsoccerdata::getCurrentData(b1,1,1),engsoccerdata::getCurrentData(b2,2,2))
df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
germ <- engsoccerdata::germany
if(identical(max(df1$Date), max(germ$Date))) warning("The returned dataframe contains data already included in 'germany' dataframe")
tm <- engsoccerdata::teamnames
df1$home <- tm$name[match(df1$home,tm$name_other)]
df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
df1<-df1[c(1:7,9,8)]
return(df1)
}

