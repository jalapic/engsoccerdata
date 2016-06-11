#' Return each team's worst losses
#'
#' @param df the results dataset
#' @param teamname team name
#' @param type If \code{=NULL} then all results are returned. If
#' Otherwise valid types are \code{H}, \code{A}
#' relating to home-losses, away-losses
#' @param N The total number of games to return
#' @return a dataframe of games ending in worst losses
#' @importFrom magrittr "%>%"
#' @importFrom utils "head"
#' @examples
#' worstlosses(england,"Everton")
#' worstlosses(england,"Aston Villa", type="H")
#' worstlosses(england,"York City", type="A")
#' worstlosses(england,"Port Vale", N=20)
#' worstlosses(england,"Hull City", type="A", N=7)
#'
#' @export



worstlosses<-function(df=NULL, teamname=NULL, type=NULL, N=NULL){

  home<-visitor<-hgoal<-vgoal<-goaldif<-FT<-Season<-division<-result<-maxgoal<-mingoal<-absgoaldif<-NULL


  N<- if(is.null(N))  10 else {N}


  if(is.null(type))

  df %>%
    dplyr::filter(home==teamname & result=="A" | visitor==teamname & result=="H") %>%
    dplyr::mutate(maxgoal=pmax(hgoal, vgoal), mingoal=pmin(hgoal,vgoal), absgoaldif=abs(hgoal-vgoal)) %>%
    dplyr::arrange(-absgoaldif,-maxgoal) %>%
    dplyr::select(Season, home, visitor, FT, division) %>%
    head(N)


  else

  {

    df %>%
      dplyr::filter(home==teamname & result=="A" | visitor==teamname & result=="H") %>%
      dplyr::mutate(maxgoal=pmax(hgoal, vgoal), mingoal=pmin(hgoal,vgoal), absgoaldif=abs(hgoal-vgoal)) %>%
      dplyr::arrange(-absgoaldif, -maxgoal) %>%
      dplyr::filter(result==type) %>%
      dplyr::select(Season, home, visitor, FT, division) %>%
      head(N)


  }

  }
