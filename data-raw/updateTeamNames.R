# Function to add unindexed team names to the teamnames dataframe.

updateTeamnames <- function(df, country = NULL) {

#find unindexed teamnames (home and away)
unique(as.factor(c(
as.character(subset(df, !(df$home %in% subset(teamnames, country==country)$name_other))$home),
as.character(subset(df, !(df$visitor %in% subset(teamnames, country==country)$name_other))$visitor)
))) %>%

#make new entry if team can't be approximately matched in the existing teamnames df
lapply(., function(x) {
  idx_name <- unique(teamnames[agrep(x, teamnames$name),]$name)
  if(length(idx_name)==0) {
    data.frame(
      country=country,
      name = x,
      name_other = x,
      most_recent = "NA")
  }
}) %>%

  #flatten list
  do.call("rbind", .) %>%

  #bind to teamnames df
  rbind(teamnames, .)
}

# example
tail(updateTeamnames(scotland, "Scotland"), 14)

