#' Return all results by team
#'
#' @param df the results dataset
#' @return a dataframe of all games by team
#' @importFrom magrittr "%>%"
#' @examples
#' homeaway(england[england$Season==2015 & england$tier==1,])
#'
#' @export

homeaway <- function(df){
  hconf <- vconf <- leg <- hgoalaet <- vgoalaet <- hpen <- vpen <- ga <- Date <- Season <- team <- opp <- gf <- division <- tier <- venue <- home <- visitor <- hgoal <- vgoal <- NULL
  if ("division" %in% colnames(df)) {
    rbind(df %>% dplyr::select(Date, Season, team = home,
                               opp = visitor, gf = hgoal, ga = vgoal, division,
                               tier) %>% dplyr::mutate(venue = "home"), df %>% dplyr::select(Date,
                                                                                             Season, team = visitor, opp = home, gf = vgoal, ga = hgoal,
                                                                                             division, tier) %>% dplyr::mutate(venue = "away")) %>%
      dplyr::arrange(team, Date)
  }
  else if("tier" %in% colnames(df)){
    rbind(df %>% dplyr::select(Date, Season, team = home,
                               opp = visitor, gf = hgoal, ga = vgoal,
                               tier) %>% dplyr::mutate(venue = "home"), df %>% dplyr::select(Date,
                                                                                             Season, team = visitor, opp = home, gf = vgoal, ga = hgoal,
                                                                                             tier) %>% dplyr::mutate(venue = "away")) %>%
      dplyr::arrange(team, Date)
  }




  else {
    rbind(df %>% dplyr::select(Date, Season, team = home,
                               opp = visitor, gf = hgoal, ga = vgoal, teamconf = hconf,
                               oppconf = vconf, round, leg, gfaet = hgoalaet, gaaet = vgoalaet,
                               penfaet = hpen, penaaet = vpen) %>% dplyr::mutate(venue = "home"),
          df %>% dplyr::select(Date, Season, team = visitor,
                               opp = home, gf = vgoal, ga = hgoal, teamconf = vconf,
                               oppconf = hconf, round, leg, gfaet = vgoalaet,
                               gaaet = hgoalaet, penfaet = vpen, penaaet = hpen) %>%
            dplyr::mutate(venue = "away")) %>% dplyr::arrange(team,
                                                              Date)
  }
}


