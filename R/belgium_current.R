#' Get current Belgium season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#'
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' belgium_current()
#' @export


belgium_current <- function(Season=2017){

s1<-s2<-myseason<-b1<-df1<-NULL
myseason<-Season
s2<-as.numeric(substr(myseason,3,4))
s1 <- s2+1
b1<- read.csv(paste0("http://www.football-data.co.uk/mmz4281/",s2,s1,"/B1.csv"))
df1 <- rbind(engsoccerdata::getCurrentData(b1,'B1',1,Season=myseason))

df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
belg <- engsoccerdata::belgium
if(identical(max(df1$Date), max(belg$Date))) warning("The returned dataframe contains data already included in 'belgium' dataframe")
tm <- engsoccerdata::teamnames
df1$home <- tm$name[match(df1$home,tm$name_other)]
df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
return(df1)
}
