#' Return all instances of a team scoring n goals
#'
#' @param df The results dataframe
#' @param n Number of goals
#' @param teamname teamname
#' @return a dataframe with summary of results.
#' @importFrom magrittr "%>%"
#' @examples
#' ngoals(england, 7, "York City")
#' ngoals(england, 8, "Manchester United")
#' ngoals(england, 9, "Aston Villa")
#'
#' @export

ngoals<-function (df=NULL, n=NULL, teamname=NULL) {

  .<-Date<-tier<-home<-visitor<-hgoal<-vgoal<-goaldif<-FT<-Season<-division<-result<-maxgoal<-mingoal<-absgoaldif<-NULL

  tmp <-df %>%
    dplyr::filter(hgoal>=n & home==teamname | vgoal>=n & visitor == teamname) %>%
    dplyr::select(Date,Season,home,visitor,FT, division,tier) %>%
    dplyr::arrange(Season)

  return(tmp)
  }
