#' Get current Portugal season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' portugal_current()
#' @export
portugal_current <- function(Season = 2025){

  s1 <- s2 <- myseason <- p1 <- df1 <- NULL
  myseason <- Season
  s2 <- as.numeric(substr(myseason, 3, 4))
  s1 <- s2 + 1

  # Fetch (Primeira Liga)
  p1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/P1.csv"))

  # Standardize
  df1 <- rbind(engsoccerdata::getCurrentData(p1, "P1", 1, Season = myseason))

  # Date class for checks
  df1$Date <- as.Date(df1$Date, format = "%Y-%m-%d")

  # Keep raw names
  home_raw <- df1$home
  visitor_raw <- df1$visitor

  # Map team names
  tm <- engsoccerdata::teamnames
  df1$home <- tm$name[match(home_raw, tm$name_other)]
  df1$visitor <- tm$name[match(visitor_raw, tm$name_other)]

  # Guard missing mappings
  if (anyNA(df1$home) || anyNA(df1$visitor)) {

    missing_home <- sort(unique(home_raw[is.na(df1$home)]))
    missing_visitor <- sort(unique(visitor_raw[is.na(df1$visitor)]))
    missing_all <- sort(unique(c(missing_home, missing_visitor)))

    warning(
      "Teamnames not matched to canonical names. Add these to teamnames$name_other: ",
      paste(missing_all, collapse = "; ")
    )
  }

  # True overlap warning
  pt <- engsoccerdata::portugal
  pt_key <- paste(pt$Date, pt$Season, pt$division, pt$tier, pt$home, pt$visitor, sep = "|")
  df1_key <- paste(as.character(df1$Date), df1$Season, df1$division, df1$tier, df1$home, df1$visitor, sep = "|")

  n_overlap <- sum(df1_key %in% pt_key)
  if (n_overlap > 0) {
    warning(sprintf(
      "The returned dataframe contains %d match(es) already included in the 'portugal' dataset.",
      n_overlap
    ))
  }

  return(df1)
}
