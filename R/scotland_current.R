#' Get current Scotland season data for all tiers
#'
#' @return a dataframe with results for current
#' season for top four divisions
#' @importFrom utils "read.csv"
#' @examples
#' scotland_current()
#' @export


scotland_current <- function(){

s1<-s2<-s3<-s4<-df1<-NULL

s1=read.csv("http://www.football-data.co.uk/mmz4281/1617/SC0.csv")
s2=read.csv("http://www.football-data.co.uk/mmz4281/1617/SC1.csv")
s3=read.csv("http://www.football-data.co.uk/mmz4281/1617/SC2.csv")
s4=read.csv("http://www.football-data.co.uk/mmz4281/1617/SC3.csv")
df1 <- rbind(engsoccerdata::getCurrentData(s1,'SCO',1),engsoccerdata::getCurrentData(s2,'SC1',2),
             engsoccerdata::getCurrentData(s3,'SC2',3),engsoccerdata::getCurrentData(s4,'SC3',4))
df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
scot <- engsoccerdata::scotland
if(identical(max(df1$Date), max(scot$Date))) warning("The returned dataframe contains data already included in 'scotland' dataframe")
tm <- engsoccerdata::teamnames
df1$home <- tm$name[match(df1$home,tm$name_other)]
df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
return(df1)
}
