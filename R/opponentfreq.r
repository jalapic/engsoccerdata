#' The number of times a team has played against each opponent
#'
#' @param df The results dataframe
#' @param teamname teamname
#' @return a dataframe with frequency of matches and team.
#' @importFrom magrittr "%>%"
#' @examples
#' opponentfreq(england, "Aston Villa")
#' opponentfreq(england, "York City")
#' opponentfreq(england, "Milton Keynes Dons")
#' @export


opponentfreq<-function(df=NULL, teamname=NULL){

  n<-.<-Date<-tier<-home<-team<-visitor<-hgoal<-vgoal<-goaldif<-FT<-Season<-division<-result<-maxgoal<-mingoal<-absgoaldif<-NULL

temp<-df %>%
  dplyr::filter(home==teamname) %>%
  dplyr::select(team=visitor)

temp1<-df %>%
  dplyr::filter(visitor==teamname) %>%
  dplyr::select(team=home)

temp2 <- rbind(temp,temp1)%>%
  dplyr::group_by(team) %>%
  dplyr::tally() %>%
  dplyr::arrange(-n)

return(as.data.frame(unclass(temp2)))

}
