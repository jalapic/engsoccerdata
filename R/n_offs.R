#' Return Scorelines that only occurred n times in history
#'
#' note don't try this with 0 - won't return infinite possible scorelines
#' If you pick crazy numbers for the number of times e.g. 34223, you'll get an error message
#' this function is meant for small numbers of occurrences
#'
#' @param df df
#' @param N N
#' @param Tier Tier
#'
#' @examples
#' df <- engsoccerdata2
#' n_offs(df, 1) #return results that have occurred only once across all four tiers
#' n_offs(df, 2) #return results that have occurred only twice across all four tiers
#' n_offs(df, 3) #return results that have occurred 3 times across all four tiers
#'
#' n_offs(df, 1, 1) #return which results have occurred only once in the top tier
#' n_offs(df, 1, 4) #return which results have occurred only once in the 4th tier
#' n_offs(df, 2, 2) #return which results have occurred twice in the 2nd tier
#' n_offs(df, 5, 3) #return which results have occurred five times in the 3rd tier
#'
#' @export
n_offs<- function(df, N, Tier=NULL){

  if(is.null(Tier))
    df %>%
    group_by(FT)%>%
    tally %>%
    filter (n==N) %>%
    select (FT) %>%
    left_join(df) %>%
    select (Date, Season, home, visitor, FT, division, tier, result)%>%
    arrange(FT, Season)

  else

    {dfTier<-df %>%
    filter(tier==Tier)

    dfTier%>%
    group_by(FT)%>%
    tally %>%
    filter (n==N) %>%
    select (FT) %>%
    left_join(dfTier) %>%
    select (Date, Season, home, visitor, FT, division, tier, result)%>%
    arrange(FT, Season)
    }
}
