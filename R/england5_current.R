#' Get current Enland season data for tier 5
#'
#' @return a dataframe with results for current
#' season for top two divisions
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' england5_current()
#' @export


england5_current <- function(Season=2017){

  s1<-s2<-myseason<-e1<-df1<-NULL
  myseason<-Season
  s2<-as.numeric(substr(myseason,3,4))
  s1 <- s2+1

e1=read.csv(paste0("http://www.football-data.co.uk/mmz4281/",s2,s1,"/EC.csv"))
df1 <- engsoccerdata::getCurrentData(e1,5,5,Season=myseason)

df1$Date <- as.Date(df1$Date, format="%Y-%m-%d")
e5 <- engsoccerdata::england5
if(identical(max(df1$Date,na.rm=T), max(e5$Date,na.rm = T))) warning("The returned dataframe contains data already included in 'england5' dataframe")
tm <- engsoccerdata::teamnames

df1$home <- tm$name[match(df1$home,tm$name_other)]
df1$visitor <- tm$name[match(df1$visitor,tm$name_other)]

df1<-df1[c(1:7,9,8)]
return(df1)
}

