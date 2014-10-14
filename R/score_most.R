#' This returns the team who has been involved in the most games of each scoreline
#'
#' @param df df
#' @param score score
#'
#' @examples
#' df <- engsoccerdata2
#' score_most(df, "6-6") # Arsenal 1  Charlton Athletic 1  Leicester City 1  Middlesbrough 1
#' score_most(df, "5-5") # Blackburn Rovers 3   West Ham United 3
#' score_most(df, "4-4") # Tottenham Hotspur 14
#' score_most(df, "3-3") # Manchester City 68   Wolverhampton Wanderers 68
#' score_most(df, "2-2") # Leicester City 274
#' score_most(df, "1-1") # Sheffield United 560
#' score_most(df, "0-0") # Notts County 363
#'
#' score_most(df, "1-0") # Birmingham City 795 - most involved in 1-0 or 0-1 games
#' score_most(df, "8-0") # Arsenal 7 - most involved in 8-0 or 0-8 games
#' score_most(df, "9-1") # Notts County 4 - most involved in 4-1 or 1-4 games
#'
#' @export
score_most<-function (df, score){


  temp<-strsplit(score,split="-")
  temp<-as.vector(unlist(temp[[1]]))
  score1<-paste(temp[2],temp[1],sep="-")

  df %>%
    filter(FT == score | FT == score1) %>%
    select(Season, home, visitor) %>%
    gather(key, team, home:visitor) %>%
    group_by(team)  %>%
    tally %>%
    arrange(desc(n)) %>%
    filter (n==max(n))
}
