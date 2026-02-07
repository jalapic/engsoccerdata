library(dplyr)

current_fns <- ls("package:engsoccerdata", pattern = "_current$")

check_one_current <- function(fn_name, Season = 2025){
  fn <- get(fn_name, asNamespace("engsoccerdata"))

  warns <- character(0)
  out <- tryCatch(
    withCallingHandlers(
      fn(Season = Season),
      warning = function(w){
        warns <<- c(warns, conditionMessage(w))
        invokeRestart("muffleWarning")
      }
    ),
    error = function(e) e
  )

  if (inherits(out, "error")) {
    return(data.frame(
      function_name = fn_name,
      season = Season,
      ok = FALSE,
      n = NA_integer_,
      home_na = NA_integer_,
      visitor_na = NA_integer_,
      warnings = paste(warns, collapse = " | "),
      error = conditionMessage(out),
      stringsAsFactors = FALSE
    ))
  }

  data.frame(
    function_name = fn_name,
    season = Season,
    ok = TRUE,
    n = nrow(out),
    home_na = sum(is.na(out$home)),
    visitor_na = sum(is.na(out$visitor)),
    warnings = paste(warns, collapse = " | "),
    error = NA_character_,
    stringsAsFactors = FALSE
  )
}

qc_results <- bind_rows(lapply(current_fns, check_one_current, Season = 2025)) %>%
  arrange(ok, desc(home_na + visitor_na), function_name)

qc_results


## Oviedo

#use check current teamnames
engsoccerdata::teamnames[grepl("vie", engsoccerdata::teamnames$name),]  #
#UD Almeria

teamnames <-
  rbind(teamnames,
        data.frame(
          country = "Spain",
          name = c("Real Oviedo"),
          name_other = c("Oviedo"),
          most_recent = NA
        )
  )

head(teamnames)
tail(teamnames)

## update steps
usethis::use_data(teamnames, overwrite = T)
write.csv(teamnames,'data-raw/teamnames.csv',row.names=F)
# redo documentation
devtools::document()


s25 <- engsoccerdata::spain_current(Season = 2025)
sum(is.na(s25$home)); sum(is.na(s25$visitor))
