#### Number of Games in Each Tier

games_by_tier<-function(df,Tier=NULL){
  
  if(is.null(Tier)) 
    df %>%
    select(Season, tier, home, visitor) %>%
    gather (venue, team, home:visitor) %>%
    group_by(team,tier) %>%
    summarise(total=n()) %>%
    arrange (desc(total))
  
  else
    
  {
    dfTier<-df %>%
     filter(tier==Tier) 
   
   dfTier %>%
     select(Season, tier, home, visitor) %>%
     gather (venue, team, home:visitor) %>%
     group_by(team,tier) %>%
     summarise(total=n()) %>%
     arrange (desc(total))
   
  }
}


# Examples

games_by_tier(df, 1)
games_by_tier(df, 2)
games_by_tier(df, 3)
games_by_tier(df, 4)

as.data.frame(unclass(games_by_tier(df))) #all games by all teams in all tiers
