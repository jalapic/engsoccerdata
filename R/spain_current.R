#' Get current Spain season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' spain_current()
#' @export
spain_current <- function(Season = 2025){

  s1 <- s2 <- myseason <- sp1 <- df1 <- NULL
  myseason <- Season
  s2 <- as.numeric(substr(myseason, 3, 4))
  s1 <- s2 + 1

  # Fetch
  sp1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/SP1.csv"))

  # Standardize using existing helper
  df1 <- engsoccerdata::getCurrentData(sp1, "SP1", 1, Season = myseason)

  # Ensure Date is Date class for comparisons
  df1$Date <- as.Date(df1$Date, format = "%Y-%m-%d")

  # Keep raw names before mapping (for informative warnings)
  home_raw <- df1$home
  visitor_raw <- df1$visitor

  # Canonicalize team names
  tm <- engsoccerdata::teamnames
  df1$home <- tm$name[match(home_raw, tm$name_other)]
  df1$visitor <- tm$name[match(visitor_raw, tm$name_other)]

  # Guard: warn if any teamnames did not map
  if (anyNA(df1$home) || anyNA(df1$visitor)) {

    missing_home <- sort(unique(home_raw[is.na(df1$home)]))
    missing_visitor <- sort(unique(visitor_raw[is.na(df1$visitor)]))
    missing_all <- sort(unique(c(missing_home, missing_visitor)))

    warning(
      "Teamnames not matched to canonical names. Add these to teamnames$name_other: ",
      paste(missing_all, collapse = "; ")
    )
  }

  # Warn only if there is true overlap with the stored spain dataset
  spai <- engsoccerdata::spain
  sp_key <- paste(spai$Date, spai$Season, spai$home, spai$visitor, spai$tier, sep = "|")
  df1_key <- paste(as.character(df1$Date), df1$Season, df1$home, df1$visitor, df1$tier, sep = "|")

  n_overlap <- sum(df1_key %in% sp_key)
  if (n_overlap > 0) {
    warning(sprintf(
      "The returned dataframe contains %d match(es) already included in the 'spain' dataset.",
      n_overlap
    ))
  }

  # Conform to spain dataset columns
  # Current getCurrentData returns: Date, Season, home, visitor, FT, hgoal, vgoal, division, tier, totgoal, goaldif, result
  # Spain dataset expects: Date, Season, home, visitor, HT, FT, hgoal, vgoal, tier, round, group, notes

  df1 <- df1[c("Date", "Season", "home", "visitor", "FT", "hgoal", "vgoal", "tier")]
  df1$round <- "league"
  df1$group <- NA
  df1$notes <- NA
  df1$HT <- NA

  # Reorder to match existing spain data
  df1 <- df1[c("Date", "Season", "home", "visitor", "HT", "FT", "hgoal", "vgoal", "tier", "round", "group", "notes")]

  return(df1)
}
