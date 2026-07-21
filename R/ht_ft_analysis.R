#' Get 1st half and 2nd half goals breakdown between two teams
#'
#' @param df The results dataframe (must contain HT, FT columns with half-time data)
#' @param team1 First team name
#' @param team2 Second team name
#' @return dataframe with all matches between the two teams including half-time breakdown
#' @details
#' This function requires datasets with HT and FT columns including half-time goal data.
#' Use current season functions (e.g., england_current()) for this data.
#'
#' Returns columns:
#' - Date, home, visitor
#' - HT (half-time result), ht_result (H Win/A Win/Draw)
#' - ht_hgoal, ht_vgoal (half-time goals for each team)
#' - FT (full-time result), h2_result (2nd half result)
#' - h2_hgoal, h2_vgoal (2nd half goals)
#' - h2_total_goals (total goals scored in 2nd half)
#'
#' @examples
#' \dontrun{
#' eng_current <- england_current()
#' games_ht_ft_breakdown(eng_current, "Arsenal", "Manchester United")
#' }
#' @export

games_ht_ft_breakdown <- function(df, team1, team2){

  # Check for required columns
  required_cols <- c("Date", "home", "visitor", "HT", "FT", "ht_hgoal", "ht_vgoal", "h2_hgoal", "h2_vgoal")
  missing_cols <- setdiff(required_cols, names(df))

  if (length(missing_cols) > 0) {
    stop("DataFrame must contain HT and FT columns with half-time goal data. ",
         "Missing columns: ", paste(missing_cols, collapse = ", "),
         "\nUse current season functions (e.g., england_current()) for half-time data.")
  }

  # Find all matches between the two teams
  matches <- df[((df$home == team1 & df$visitor == team2) |
                   (df$home == team2 & df$visitor == team1)), ]

  if (nrow(matches) == 0) {
    message("No matches found between ", team1, " and ", team2)
    return(data.frame())
  }

  # Calculate half-time and second-half results
  matches$ht_result <- with(matches, ifelse(ht_hgoal > ht_vgoal, "H Win",
                                            ifelse(ht_hgoal < ht_vgoal, "A Win", "Draw")))

  matches$h2_result <- with(matches, ifelse(h2_hgoal > h2_vgoal, "H Win",
                                            ifelse(h2_hgoal < h2_vgoal, "A Win", "Draw")))

  matches$h2_total_goals <- matches$h2_hgoal + matches$h2_vgoal

  # Return key columns
  return(matches[, c("Date", "home", "visitor", "HT", "ht_result", "ht_hgoal", "ht_vgoal",
                     "FT", "h2_result", "h2_hgoal", "h2_vgoal", "h2_total_goals")])
}


#' Get half-time performance stats for a team
#'
#' @param df The results dataframe (must contain HT/FT columns with half-time data)
#' @param team Team name
#' @return dataframe with half-time statistics (home and away)
#' @details
#' Returns statistics for:
#' - Home HT: half-time record at home
#' - Away HT: half-time record away
#'
#' Columns: Team, Status, W (wins), D (draws), L (losses), GF (goals for), GA (goals against), GD (goal difference)
#'
#' @examples
#' \dontrun{
#' eng_current <- england_current()
#' ht_team_stats(eng_current, "Arsenal")
#' }
#' @export

ht_team_stats <- function(df, team){

  required_cols <- c("home", "visitor", "ht_hgoal", "ht_vgoal", "hgoal", "vgoal")
  missing_cols <- setdiff(required_cols, names(df))

  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  # Get all games for this team
  home_games <- df[df$home == team, ]
  away_games <- df[df$visitor == team, ]

  # Calculate HT stats
  ht_home_w <- sum(home_games$ht_hgoal > home_games$ht_vgoal, na.rm = TRUE)
  ht_home_d <- sum(home_games$ht_hgoal == home_games$ht_vgoal, na.rm = TRUE)
  ht_home_l <- sum(home_games$ht_hgoal < home_games$ht_vgoal, na.rm = TRUE)
  ht_home_gf <- sum(home_games$ht_hgoal, na.rm = TRUE)
  ht_home_ga <- sum(home_games$ht_vgoal, na.rm = TRUE)

  ht_away_w <- sum(away_games$ht_vgoal > away_games$ht_hgoal, na.rm = TRUE)
  ht_away_d <- sum(away_games$ht_hgoal == away_games$ht_vgoal, na.rm = TRUE)
  ht_away_l <- sum(away_games$ht_vgoal < away_games$ht_hgoal, na.rm = TRUE)
  ht_away_gf <- sum(away_games$ht_vgoal, na.rm = TRUE)
  ht_away_ga <- sum(away_games$ht_hgoal, na.rm = TRUE)

  data.frame(
    "Team" = team,
    "Status" = c("Home HT", "Away HT"),
    "W" = c(ht_home_w, ht_away_w),
    "D" = c(ht_home_d, ht_away_d),
    "L" = c(ht_home_l, ht_away_l),
    "GF" = c(ht_home_gf, ht_away_gf),
    "GA" = c(ht_home_ga, ht_away_ga),
    "GD" = c(ht_home_gf - ht_home_ga, ht_away_gf - ht_away_ga),
    stringsAsFactors = FALSE
  )
}


#' Compare team performance in 1st half vs 2nd half
#'
#' @param df The results dataframe (must contain HT/FT columns)
#' @param team Team name
#' @return comparison of HT and FT performance
#' @examples
#' \dontrun{
#' eng_current <- england_current()
#' ht_vs_ft_comparison(eng_current, "Arsenal")
#' }
#' @export

ht_vs_ft_comparison <- function(df, team){

  required_cols <- c("home", "visitor", "ht_hgoal", "ht_vgoal", "hgoal", "vgoal")
  missing_cols <- setdiff(required_cols, names(df))

  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  # Full-time stats
  home_games <- df[df$home == team, ]
  away_games <- df[df$visitor == team, ]

  ft_home_w <- sum(home_games$hgoal > home_games$vgoal, na.rm = TRUE)
  ft_home_d <- sum(home_games$hgoal == home_games$vgoal, na.rm = TRUE)
  ft_home_l <- sum(home_games$hgoal < home_games$vgoal, na.rm = TRUE)

  ft_away_w <- sum(away_games$vgoal > away_games$hgoal, na.rm = TRUE)
  ft_away_d <- sum(away_games$hgoal == away_games$vgoal, na.rm = TRUE)
  ft_away_l <- sum(away_games$vgoal < away_games$hgoal, na.rm = TRUE)

  # Half-time stats
  ht_home_w <- sum(home_games$ht_hgoal > home_games$ht_vgoal, na.rm = TRUE)
  ht_home_d <- sum(home_games$ht_hgoal == home_games$ht_vgoal, na.rm = TRUE)
  ht_home_l <- sum(home_games$ht_hgoal < home_games$ht_vgoal, na.rm = TRUE)

  ht_away_w <- sum(away_games$ht_vgoal > away_games$ht_hgoal, na.rm = TRUE)
  ht_away_d <- sum(away_games$ht_hgoal == away_games$ht_vgoal, na.rm = TRUE)
  ht_away_l <- sum(away_games$ht_vgoal < away_games$ht_hgoal, na.rm = TRUE)

  data.frame(
    "Team" = team,
    "Venue" = c("Home", "Home", "Away", "Away"),
    "Period" = c("HT", "FT", "HT", "FT"),
    "W" = c(ht_home_w, ft_home_w, ht_away_w, ft_away_w),
    "D" = c(ht_home_d, ft_home_d, ht_away_d, ft_away_d),
    "L" = c(ht_home_l, ft_home_l, ht_away_l, ft_away_l),
    stringsAsFactors = FALSE
  )
}
