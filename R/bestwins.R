#' Return each team's best wins
#'
#' @param df the results dataset
#' @param teamname team name
#' @param type If \code{=NULL} then all results are returned. If
#' Otherwise valid types are \code{H}, \code{A}
#' relating to home-losses, away-losses
#' @param N The total number of games to return
#' @return a dataframe of games ending in best wins
#' @importFrom magrittr "%>%"
#' @importFrom utils "head"
#' @examples
#' bestwins(england,"Everton")
#' bestwins(england,"Aston Villa", type="H")
#' bestwins(england,"York City", type="A")
#' bestwins(england,"Port Vale", N=20)
#'
#' @export


bestwins<-function(df=NULL, teamname=NULL, type=NULL, N=NULL){

  home<-visitor<-hgoal<-vgoal<-goaldif<-FT<-Season<-division<-result<-maxgoal<-mingoal<-absgoaldif<-NULL

  N<- if(is.null(N))  10 else {N}


  if(is.null(type))

    df %>%
    dplyr::filter(home==teamname & result=="H" | visitor==teamname & result=="A") %>%
    dplyr::mutate(maxgoal=pmax(hgoal, vgoal), mingoal=pmin(hgoal,vgoal), absgoaldif=abs(hgoal-vgoal)) %>%
    dplyr::arrange(-absgoaldif,-maxgoal) %>%
    dplyr::select(Season, home, visitor, FT, division) %>%
    head(N)

  else

  {

    df %>%
      dplyr::filter(home==teamname & result=="H" | visitor==teamname & result=="A") %>%
      dplyr::mutate(maxgoal=pmax(hgoal, vgoal), mingoal=pmin(hgoal,vgoal), absgoaldif=abs(hgoal-vgoal)) %>%
      dplyr::arrange(-absgoaldif,-maxgoal) %>%
      dplyr::filter(result==type) %>%
      dplyr::select(Season, home, visitor, FT, division) %>%
      head(N)


  }
}
