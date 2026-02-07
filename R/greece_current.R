#' Get current Greece season data for top tier
#'
#' @return a dataframe with results for current
#' season for top division
#' @param Season the current Season
#' @importFrom utils "read.csv"
#' @examples
#' greece_current()
#' @export
greece_current <- function(Season = 2025){

  s1 <- s2 <- myseason <- g1 <- df1 <- NULL
  myseason <- Season
  s2 <- as.numeric(substr(myseason, 3, 4))
  s1 <- s2 + 1

  g1 <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s2, s1, "/G1.csv"))
  df1 <- rbind(engsoccerdata::getCurrentData(g1, "G1", 1, Season = myseason))

  df1$Date <- as.Date(df1$Date, format = "%Y-%m-%d")

  home_raw <- df1$home
  visitor_raw <- df1$visitor

  tm <- engsoccerdata::teamnames
  df1$home <- tm$name[match(home_raw, tm$name_other)]
  df1$visitor <- tm$name[match(visitor_raw, tm$name_other)]

  if (anyNA(df1$home) || anyNA(df1$visitor)) {
    missing_all <- sort(unique(c(
      home_raw[is.na(df1$home)],
      visitor_raw[is.na(df1$visitor)]
    )))
    warning(
      "Teamnames not matched to canonical names. Add these to teamnames$name_other: ",
      paste(missing_all, collapse = "; ")
    )
  }

  gr <- engsoccerdata::greece
  gr_key <- paste(gr$Date, gr$Season, gr$division, gr$tier, gr$home, gr$visitor, sep = "|")
  df1_key <- paste(as.character(df1$Date), df1$Season, df1$division, df1$tier, df1$home, df1$visitor, sep = "|")

  n_overlap <- sum(df1_key %in% gr_key)
  if (n_overlap > 0) {
    warning(sprintf(
      "The returned dataframe contains %d match(es) already included in the 'greece' dataset.",
      n_overlap
    ))
  }

  target_cols <- colnames(engsoccerdata::greece)
  missing_cols <- setdiff(target_cols, colnames(df1))
  if (length(missing_cols) > 0) for (cc in missing_cols) df1[[cc]] <- NA
  df1 <- df1[target_cols]

  return(df1)
}
