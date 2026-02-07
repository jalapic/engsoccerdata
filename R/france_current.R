#' Get current France season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' france_current()
#' @export
france_current <- function(Season = 2025){

  s1 <- s2 <- myseason <- f1 <- df1 <- NULL
  myseason <- Season
  s2 <- as.numeric(substr(myseason, 3, 4))
  s1 <- s2 + 1

  # Fetch (Ligue 1)
  f1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/F1.csv"))

  # Standardize using existing helper
  df1 <- rbind(engsoccerdata::getCurrentData(f1, "F1", 1, Season = myseason))

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

  # Warn only if there is true overlap with the stored france dataset
  fran <- engsoccerdata::france
  fran_key <- paste(fran$Date, fran$Season, fran$division, fran$tier, fran$home, fran$visitor, sep = "|")
  df1_key  <- paste(as.character(df1$Date), df1$Season, df1$division, df1$tier, df1$home, df1$visitor, sep = "|")

  n_overlap <- sum(df1_key %in% fran_key)
  if (n_overlap > 0) {
    warning(sprintf(
      "The returned dataframe contains %d match(es) already included in the 'france' dataset.",
      n_overlap
    ))
  }

  return(df1)
}
