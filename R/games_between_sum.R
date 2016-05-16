#' Function to List the summary stats of all games ever between two teams
#'
#' @param df The results dataframe
#' @param teamname1 teamname1
#' @param teamname2 teamname2
#' @return a dataframe with summary of results. Will be
#' empty dataframe if never played.
#' @importFrom magrittr "%>%"
#' @examples
#' games_between_sum(england, "Exeter City", "York City")
#' games_between_sum(england, "Aston Villa", "York City")
#' games_between_sum(england, "Manchester United", "Liverpool")
#' @export


games_between_sum<-function (df=NULL, teamname1=NULL, teamname2=NULL) {

  .<-home<-visitor<-hgoal<-vgoal<-goaldif<-FT<-Season<-division<-result<-maxgoal<-mingoal<-absgoaldif<-NULL


  tmp<- df %>%
    dplyr::group_by(home) %>%
    dplyr::filter(home==teamname1 & visitor==teamname2 | home==teamname2 & visitor==teamname1) %>%
    dplyr::mutate(goaldif  = hgoal-vgoal,
                  result = ifelse(hgoal>vgoal, "H", ifelse(hgoal<vgoal, "A", "D"))) %>%
    dplyr::summarise(P = nrow(.), GF = sum(hgoal), GA = sum(vgoal), GD=sum(goaldif),
              W=sum(result=="H"), D=sum(result=="D"), L=sum(result=="A") )

  return(as.data.frame(tmp))
  }
