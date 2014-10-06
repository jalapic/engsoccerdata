#' Return each team's record win (top 5 etc)
#'
#' @examples
#' bestwins(df,"Everton")
#' bestwins(df,"Aston Villa", type="H")
#' bestwins(df,"York City", type="A")
#' bestwins(df,"Port Vale", N=20)
#' bestwins(df,"Hull City", type="A", N=7)
#'
#' @export
bestwins<-function(df, teamname, type=NULL, N=NULL){

N<- if(is.null(N))  10 else {N}

library(tidyr)
library(dplyr)

if(is.null(type))

df %>%
  filter(home==teamname & result=="H" | visitor==teamname & result=="A") %>%
  mutate(maxgoal=pmax(hgoal, vgoal), mingoal=pmin(hgoal,vgoal), absgoaldif=abs(goaldif)) %>%
  arrange(desc(absgoaldif),desc(maxgoal)) %>%
  select (Season, home, visitor, FT, division) %>%
  head(N)

else

{

  df %>%
  filter(home==teamname & result=="H" | visitor==teamname & result=="A") %>%
  mutate(maxgoal=pmax(hgoal, vgoal), mingoal=pmin(hgoal,vgoal), absgoaldif=abs(goaldif)) %>%
  arrange(desc(absgoaldif),desc(maxgoal)) %>%
  select (Season, home, visitor, FT, division) %>%
  filter (result==type) %>%
  head(N)


}
}
