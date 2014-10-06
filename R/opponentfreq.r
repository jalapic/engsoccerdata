#' function to see number of times  played against each opponent
#'
#' @param df df
#' @param teamname teamname
#'
#' @examples
#' df <- engsoccerdata2
#' opponentfreq(df, "Exeter City")  #just gives top few opponents
#' opponentfreq(df, "Aston Villa")
#' opponentfreq(df, "Everton")
#' opponentfreq(df, "York City")
#' opponentfreq(df, "Bolton Wanderers")
#' opponentfreq(df, "Milton Keynes Dons")
#'
#' as.data.frame(unclass(opponentfreq(df, "Exeter City"))) #view all opponents
#'
#' @export
opponentfreq<-function(df, teamname){

temp<-df %>%
  filter (home==teamname) %>%
  select (team=visitor)

temp1<-df %>%
  filter (visitor==teamname) %>%
  select (team=home)

rbind(temp,temp1)%>%
  group_by(team) %>%
  tally %>%
  arrange (desc(n))
}
