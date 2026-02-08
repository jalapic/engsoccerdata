#' Get current England season data for tier 5
#'
#' @return A dataframe with results for current season for tier 5 (National League)
#' @param Season The current Season (starting year, e.g. 2025 for 2025/26)
#' @importFrom utils read.csv
#' @export
england5_current <- function(Season = 2025){

  s2 <- as.numeric(substr(Season, 3, 4))
  s1 <- s2 + 1

  url <- paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/EC.csv")

  e1 <- tryCatch(
    utils::read.csv(url),
    error = function(e) NULL
  )

  if (is.null(e1) || nrow(e1) == 0) {
    stop("Could not load tier 5 data from football-data.co.uk (empty/missing file): ", url)
  }

  needed <- c("Date","HomeTeam","AwayTeam","FTHG","FTAG")
  missing_cols <- setdiff(needed, names(e1))
  if (length(missing_cols) > 0) {
    stop("Tier 5 CSV is missing required columns: ",
         paste(missing_cols, collapse = ", "),
         ". Source: ", url)
  }

  df1 <- engsoccerdata::getCurrentData(e1, division = 5, tier = 5, Season = Season)

  # Keep Date as Date in returned current() frames (matches your other _current funcs)
  df1$Date <- as.Date(df1$Date, format = "%Y-%m-%d")

  # Teamname standardization (England only)
  tm <- engsoccerdata::teamnames
  tm_eng <- tm[tm$country == "England", , drop = FALSE]

  home_std <- tm_eng$name[match(df1$home, tm_eng$name_other)]
  vis_std  <- tm_eng$name[match(df1$visitor, tm_eng$name_other)]

  bad_home <- sort(unique(df1$home[is.na(home_std)]))
  bad_vis  <- sort(unique(df1$visitor[is.na(vis_std)]))
  bad_all  <- sort(unique(c(bad_home, bad_vis)))

  if (length(bad_all) > 0) {
    warning(
      "Teamnames not matched to canonical names. Add these to teamnames$name_other: ",
      paste(bad_all, collapse = ", ")
    )
  }

  df1$home <- ifelse(is.na(home_std), df1$home, home_std)
  df1$visitor <- ifelse(is.na(vis_std), df1$visitor, vis_std)

  # Put columns in same order as england5 dataset
  df1 <- df1[, c("Date","Season","home","visitor","FT","hgoal","vgoal","division","tier","totgoal","goaldif","result")]

  return(df1)
}
