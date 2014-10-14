#' Return each team's worst losses
#'
#' @param df df
#' @param teamname teamname
#' @param type type
#' @param N N
#'
#' @examples
#' df <- engsoccerdata2
#' worstlosses(df,"Everton")
#' worstlosses(df,"Aston Villa", type="H")
#' worstlosses(df,"York City", type="A")
#' worstlosses(df,"Port Vale", N=20)
#' worstlosses(df,"Hull City", type="A", N=7)
#'
#' @export
worstlosses<-function(df, teamname, type=NULL, N=NULL){


  N<- if(is.null(N))  10 else {N}


  if(is.null(type))

    df %>%
    filter(home==teamname & result=="A" | visitor==teamname & result=="H") %>%
    mutate(maxgoal=pmax(hgoal, vgoal), mingoal=pmin(hgoal,vgoal), absgoaldif=abs(goaldif)) %>%
    arrange(desc(absgoaldif),desc(maxgoal)) %>%
    select (Season, home, visitor, FT, division) %>%
    head(N)

  else

  {

    df %>%
      filter(home==teamname & result=="A" | visitor==teamname & result=="H") %>%
      mutate(maxgoal=pmax(hgoal, vgoal), mingoal=pmin(hgoal,vgoal), absgoaldif=abs(goaldif)) %>%
      arrange(desc(absgoaldif),desc(maxgoal)) %>%
      filter (result==type) %>%
      select (Season, home, visitor, FT, division) %>%
      head(N)


  }
}
