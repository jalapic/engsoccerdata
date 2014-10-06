#' Number of Seasons in Each Tier
#'
#' @param df df
#' @param Tier Tier
#'
#' @examples
#' df <- engsoccerdata2
#' seasons_by_tier(df, 1)
#' seasons_by_tier(df, 2)
#' seasons_by_tier(df, 3)
#' seasons_by_tier(df, 4)
#'
#' as.data.frame(unclass(seasons_by_tier(df))) #all seasons by all teams in all tiers
#'
#' @export
seasons_by_tier<-function(df,Tier=NULL){

  if(is.null(Tier))
df %>%
  select(Season, tier, home, visitor) %>%
  gather (venue, team, home:visitor) %>%
  select(-venue) %>%
  group_by(team,tier) %>%
  summarise(Seasons=n_distinct(Season)) %>%
  arrange(desc(Seasons))

else

{
  dfTier<-df %>%
    filter(tier==Tier)

  dfTier %>%
    select(Season, tier, home, visitor) %>%
    gather (venue, team, home:visitor) %>%
    select(-venue) %>%
    group_by(team,tier) %>%
    summarise(Seasons=n_distinct(Season)) %>%
    arrange(desc(Seasons))
}
}
