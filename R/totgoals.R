#' Return all instances of a team being involved in a game with n goals
#'
#' @param df The results dataframe
#' @param N Number of goals
#' @param teamname teamname
#' @return a dataframe with  matches
#' @importFrom magrittr "%>%"
#' @examples
#' totgoals(england, 10, "York City")
#' totgoals(england, 12, "Aston Villa")
#'
#' @export

totgoals<-function (df=NULL, N=NULL, teamname=NULL) {

  totgoal<-score1<-n<-.<-key<-Date<-tier<-home<-team<-visitor<-hgoal<-vgoal<-goaldif<-FT<-Season<-division<-result<-maxgoal<-mingoal<-absgoaldif<-NULL

  df %>%
    dplyr::mutate(totgoal = hgoal+vgoal) %>%
    dplyr::filter(totgoal >= N, home == teamname | visitor == teamname) %>%
    dplyr::select(Date, Season,home,visitor,FT, totgoal, tier) %>%
    dplyr::arrange(-totgoal, Season)
}
