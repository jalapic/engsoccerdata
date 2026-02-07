#' Get current Italy season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' italy_current()
#' @export
italy_current <- function(Season = 2025){

  s1 <- s2 <- myseason <- i1 <- df1 <- NULL
  myseason <- Season
  s2 <- as.numeric(substr(myseason, 3, 4))
  s1 <- s2 + 1

  # Fetch (Serie A)
  i1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/I1.csv"))

  # Standardize using existing helper
  df1 <- rbind(engsoccerdata::getCurrentData(i1, "I1", 1, Season = myseason))

  # Ensure Date is Date class for checks/keys
  df1$Date <- as.Date(df1$Date, format = "%Y-%m-%d")

  # Keep raw names before mapping
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

  # True overlap warning
  ita <- engsoccerdata::italy
  ita_key <- paste(ita$Date, ita$Season, ita$division, ita$tier, ita$home, ita$visitor, sep = "|")
  df1_key <- paste(as.character(df1$Date), df1$Season, df1$division, df1$tier, df1$home, df1$visitor, sep = "|")

  n_overlap <- sum(df1_key %in% ita_key)
  if (n_overlap > 0) {
    warning(sprintf(
      "The returned dataframe contains %d match(es) already included in the 'italy' dataset.",
      n_overlap
    ))
  }
  #df1$division <- NULL
  return(df1)
}
