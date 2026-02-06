#' Get current Germany season data for top tiers
#'
#' @return a dataframe with results for current season for Bundesliga (tier 1)
#' and 2. Bundesliga (tier 2)
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' germany_current()
#' @export
germany_current <- function(Season = 2025){

  d1 <- d2 <- s1 <- s2 <- myseason <- df1 <- NULL
  myseason <- Season
  s2 <- as.numeric(substr(myseason, 3, 4))
  s1 <- s2 + 1

  # Fetch
  d1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/D1.csv"))
  d2 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/D2.csv"))

  # Standardize using existing helper
  df1 <- rbind(
    engsoccerdata::getCurrentData(d1, "D1", 1, Season = myseason),
    engsoccerdata::getCurrentData(d2, "D2", 2, Season = myseason)
  )

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

  # Warn only if there is true overlap with the stored germany dataset
  ger <- engsoccerdata::germany
  ger_key <- paste(ger$Date, ger$Season, ger$division, ger$tier, ger$home, ger$visitor, sep = "|")
  df1_key <- paste(as.character(df1$Date), df1$Season, df1$division, df1$tier, df1$home, df1$visitor, sep = "|")

  n_overlap <- sum(df1_key %in% ger_key)
  if (n_overlap > 0) {
    warning(sprintf(
      "The returned dataframe contains %d match(es) already included in the 'germany' dataset.",
      n_overlap
    ))
  }

  # Conform to germany dataset column order/schema
  # (This makes it robust even if germany has extra columns.)
  target_cols <- colnames(engsoccerdata::germany)

  # Add any missing columns as NA, then reorder
  missing_cols <- setdiff(target_cols, colnames(df1))
  if (length(missing_cols) > 0) {
    for (cc in missing_cols) df1[[cc]] <- NA
  }
  df1 <- df1[target_cols]

  return(df1)
}
