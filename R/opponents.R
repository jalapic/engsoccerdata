#' Total number of unique opponents
#'
#' @param df A results dataframe
#' @param Tier Tier
#' @return a dataframe with teams and frequency of unique opponents
#' @importFrom magrittr "%>%"
#' @examples
#' opponents(england)
#' opponents(england,4)
#'
#' @export

opponents<-function(df=NULL,Tier=NULL){

 Opponents<-team1<-team2<- n<-.<-Date<-tier<-home<-team<-visitor<-hgoal<-vgoal<-goaldif<-FT<-Season<-division<-result<-maxgoal<-mingoal<-absgoaldif<-NULL


  if(is.null(Tier))

rbind (df %>%
         dplyr::select(team1=home,team2=visitor), df %>%
         dplyr::select(team1=visitor,team2=home)) %>%
    dplyr::group_by(team1) %>%
    dplyr::summarise(Opponents=dplyr::n_distinct(team2)) %>%
    dplyr::arrange(-Opponents)


else

{ rbind (df %>%
           dplyr::select(team1=home,team2=visitor,tier), df %>%
           dplyr::select(team1=visitor,team2=home,tier)) %>%
    dplyr::filter(tier==Tier) %>%
    dplyr::group_by(team1) %>%
    dplyr::summarise(Opponents=dplyr::n_distinct(team2)) %>%
    dplyr::arrange(-Opponents)
}
}
