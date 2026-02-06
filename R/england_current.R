#' Get current England season data for all tiers
#'
#' @return a dataframe with results for current
#' season for top four divisions
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' england_current()
#' @export
england_current <- function(Season = 2025){

  ee1 <- ee2 <- myseason <- e1 <- e2 <- e3 <- e4 <- df1 <- NULL
  myseason <- Season
  ee2 <- as.numeric(substr(myseason, 3, 4))
  ee1 <- ee2 + 1

  e1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", ee2, ee1, "/E0.csv"))
  e2 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", ee2, ee1, "/E1.csv"))
  e3 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", ee2, ee1, "/E2.csv"))
  e4 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", ee2, ee1, "/E3.csv"))

  df1 <- rbind(
    engsoccerdata::getCurrentData(e1, 1, 1, Season = myseason),
    engsoccerdata::getCurrentData(e2, 2, 2, Season = myseason),
    engsoccerdata::getCurrentData(e3, 3, 3, Season = myseason),
    engsoccerdata::getCurrentData(e4, 4, 4, Season = myseason)
  )

  # Ensure Date is Date class for sorting/joins
  df1$Date <- as.Date(df1$Date, format = "%Y-%m-%d")

  # Keep raw names before mapping (for informative warnings)
  home_raw <- df1$home
  visitor_raw <- df1$visitor

  # Canonicalize team names using teamnames table
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

  # Warn only if there is true overlap with the stored england dataset
  eng <- engsoccerdata::england
  eng_key <- paste(eng$Date, eng$Season, eng$division, eng$home, eng$visitor, sep = "|")
  df1_key <- paste(as.character(df1$Date), df1$Season, df1$division, df1$home, df1$visitor, sep = "|")

  n_overlap <- sum(df1_key %in% eng_key)
  if (n_overlap > 0) {
    warning(sprintf(
      "The returned dataframe contains %d match(es) already included in the 'england' dataset.",
      n_overlap
    ))
  }

  return(df1)
}
