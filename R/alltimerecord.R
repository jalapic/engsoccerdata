#' Get a team's all-time record
#'
#' @param df the results dataset
#' @param teamname team name
#' @return a dataframe of all-time records
#' @importFrom magrittr "%>%"
#' @examples
#' alltimerecord(england, "Aston Villa")
#' alltimerecord(england, "York City")
#' alltimerecord(england, "Rochdale")
#' @export

alltimerecord<-function (df=NULL, teamname=NULL) {

  .<-home<-visitor<-hgoal<-vgoal<-goaldif<-FT<-GF<-GA<-GD<-P<-W<-D<-L<-Season<-division<-result<-maxgoal<-mingoal<-absgoaldif<-NULL




  hrec<-df %>%
    dplyr::filter(home==teamname)  %>%
    dplyr::mutate(result=ifelse(hgoal>vgoal, "H", ifelse(hgoal<vgoal, "A", "D"))) %>%
    dplyr::summarise(P = nrow(.), W=sum(result=="H"), D=sum(result=="D"), L=sum(result=="A"),
              GF = sum(hgoal), GA = sum(vgoal), GD=GF-GA)

  vrec<-df %>%
    dplyr::filter(visitor==teamname)  %>%
    dplyr::mutate(result=ifelse(hgoal>vgoal, "H", ifelse(hgoal<vgoal, "A", "D"))) %>%
    dplyr::summarise(P = nrow(.),  W=sum(result=="A"), D=sum(result=="D"), L=sum(result=="H"),
              GF = sum(vgoal), GA = sum(hgoal), GD=GF-GA)

  temp<-rbind(hrec,vrec,hrec+vrec)
  rownames(temp)<-c("home", "away", "total")
  return(temp)
}
