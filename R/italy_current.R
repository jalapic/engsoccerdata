#' Get current Italy season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' italy_current()
#' @export

italy_current <- function(Season=2017){


   s1<-s2<-myseason<-i1<-i2<-df1<-NULL
   myseason<-Season
   s2<-as.numeric(substr(myseason,3,4))
   s1 <- s2+1

i1=read.csv(paste0("http://www.football-data.co.uk/mmz4281/",s2,s1,"/I1.csv"))
#i2=read.csv("http://www.football-data.co.uk/mmz4281/1617/I2.csv")
#df1 <- rbind(engsoccerdata::getCurrentData(i1,'I1',1),engsoccerdata::getCurrentData(i2,'I2',2))
df1 <- rbind(engsoccerdata::getCurrentData(i1,'I1',1,Season=myseason))
df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
ital <- engsoccerdata::italy
if(identical(max(df1$Date), max(ital$Date))) warning("The returned dataframe contains data already included in 'italy' dataframe")
tm <- engsoccerdata::teamnames
df1$home <- tm$name[match(df1$home,tm$name_other)]
df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]
df1 <- df1[c(1:7,9)]
return(df1)
}

