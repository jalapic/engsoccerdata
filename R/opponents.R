#' Total number of different opponents
#'
#' @examples
#' opponents(df)  #Grimsby Town and Lincoln City have the most unique opponents - 134 each
#' opponents(df,1)
#' opponents(df,2)
#' opponents(df,3)
#' opponents(df,4)
#'
#' @export
opponents<-function(df,Tier=NULL){

  if(is.null(Tier))

rbind (df %>%select(team1=home,team2=visitor), df %>%select(team1=visitor,team2=home)) %>%
  group_by(team1) %>%
  summarise(Opponents=n_distinct(team2)) %>%
  arrange(desc(Opponents))


else

{ rbind (df %>%select(team1=home,team2=visitor,tier), df %>%select(team1=visitor,team2=home,tier)) %>%
   filter(tier==Tier) %>%
   group_by(team1) %>%
   summarise(Opponents=n_distinct(team2)) %>%
   arrange(desc(Opponents))
}
}
