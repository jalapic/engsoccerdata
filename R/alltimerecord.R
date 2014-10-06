#' Function to List the all-time records of a team
#'
#' @examples
#' df <- engsoccerdata2
#' alltimerecord(df, "Aston Villa")
#' alltimerecord(df, "Arsenal")
#' alltimerecord(df, "Liverpool")
#' alltimerecord(df, "Manchester United")
#' alltimerecord(df, "York City")
#' alltimerecord(df, "Rochdale")
#' alltimerecord(df, "Birmingham City")
#' alltimerecord(df, "Leeds City")
#'
#' @export
alltimerecord<-function (df, teamname) {


  hrec<-df %>%
    filter(home==teamname)  %>%
    summarise(P = n(), W=sum(result=="H"), D=sum(result=="D"), L=sum(result=="A"),
              GF = sum(hgoal), GA = sum(vgoal), GD=sum(goaldif))

  vrec<-df %>%
    filter(visitor==teamname)  %>%
    summarise(P = n(),  W=sum(result=="A"), D=sum(result=="D"), L=sum(result=="H"),
              GF = sum(vgoal), GA = sum(hgoal), GD=GF-GA,)

  temp<-rbind(hrec,vrec,hrec+vrec)
  rownames(temp)<-c("home", "away", "total")
  return(temp)
}
