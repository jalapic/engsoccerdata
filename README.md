On CRAN v0.1.5 as of June 12 2016 <br>
Latest GitHub version: 28 Nov 2017,  v0.1.61

#### engsoccerdata

This R package is mainly a repository for complete soccer datasets, along with some built-in functions for analyzing parts of the data. Currently I include three English ones (League data, FA Cup data, Playoff data - described below), several European leagues (Spain, Germany, Italy, Holland, France, Belgium, Portugal, Turkey, Scotland, Greece) as well as South Africa and MLS. 

Free to use for non-commerical use.   Compiled by James Curley.

Please cite as:  
James P. Curley (2016). engsoccerdata: English Soccer Data 1871-2016. R package version 0.1.5 [![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.13158.svg)](http://dx.doi.org/10.5281/zenodo.13158)

If you do use it on any publications, blogs, websites, etc. please note the source (i.e. me!).  Also, if you do use it - I would love to see any analysis produced from it etc.  Of course, I accept no responsibility for any error that may be contained herewithin.

- if you'd like to get involved and help out, please let me know.  
- if you can see better ways of writing the R code, please let me know.
- if you would like to collaborate on a project using these data, please get in touch.

Contact details:  curley  AT utexas DOT edu



### Installation

To install this directly into R.

```
library(devtools)
install_github('jalapic/engsoccerdata', username = "jalapic")
library(engsoccerdata)

data(package="engsoccerdata")    # lists datasets currently available

```

If you get an error message like this one 

```
Error in curl::curl_fetch_memory(url, handle = handle) : 
  Problem with the SSL CA cert (path? access rights?)
```
which has happened on occasions for me, try this:

```
library(RCurl)
library(httr)
set_config( config( ssl_verifypeer = 0L ) )

library(devtools)
install_github('jalapic/engsoccerdata', username = "jalapic")
library(engsoccerdata)


```









engsoccerdata
=============

Last update: 1 Oct 2017,  v0.1.6


## Datasets
-  england           - Results of all top 4 tier soccer games in England 1888-2017
-  england1939       - Contains results of abandoned 1939/40 season.
-  england5          - Results of 5th tier (conference) from 1999/2000 - 2016/17
-  facup             - Contains all FA Cup ties (not including pre-qualifying rounds) 1871-2016
-  playoffs          - Incldues 'test-matches' 1892-1897 and modern playoffs (1986/87 onwards)
-  spain             - Top flight Spanish League match results 1929-2017
-  italy             - Top flight Italian Serie A League match results 1934-2017
-  germany           - Top flight German Bundesliga 1 League match results 1963-2017 & Bundelsiga 2 league match results 1974-2017
-  holland           - Dutch Eredivisie league match results 1956-2017
-  champs            - European Cup and Champions League results 1955-2017 includes qualifiers and playoffs
-  france            - French Ligue 1 results 1933-2017
-  scotland          - Scotland top 4 tiers 1994-2017
-  portugal          - Portugal top tier 1994-2017
-  belgium           - Belgium top tier 1994-2017
-  turkey            - Turkey top tier 1994-2017
-  greece            - Greece top tier 1994-2017
-  mls               - MLS regular and postseason 1996-2016
-  safrica           - South African  top tier - 2004-2017
-  teamnames         - dataframe of alternative names and abbreviations for each team in all league data
-  mlsconfs          - available in `data-raw` - summary of conference location of each team by year.

## Help Needed !

I would love help in collating more results.  If anyone wants to work on a particular league or competition please let me know.  These are the things I'd like to work on:

- English League Cup  - data from the league cup is included but still is missing some fields. For instance the aet and pens and also northsouth data are missing. Data also generally needs checking.
- European competitions - don't currently have this data
- English Conference - need to add dates to results for seasons 1979/80-1998/98.
- English FA Cup pre-qualifying round - also no data yet.
- English other competitions - e.g. lower league cup competitions - no data yet.
- Points deductions -  a list of points deductions of teams in each Euro league over time to make tables more accurate
- Tie-breaking procedures - different Euro leagues have had different tie-breaking procedures over time. Having a record of this will help with making the `maketable` family of funcitons
- Italian League in the early years - I think the first few seasons of the league need to be triple checked.
- Double checking of consistency of teamnames in all leagues - e.g. French teams have split/diverged a lot since 1933, are they all named correctly?
-  Promotion/Relegation Playoff Results for European Leagues.
-  Extending results for Scotland, Portugal, Belgium, Turkey, Greece prior to 1994/1995.
-  For MLS 1996-1999, correct FT scores to account for which games ended in ties and were decided by shoot-outs.



## Functions 

Some built-in functions:

-  england_current().r       - get results from top 4 tiers of English football from current season.  Other current seasons for other datasets can be got by e.g. holland_current(), germany_current() etc.

-  maketable.r               - make a league table  - probably the quickest way to make a league table

-  maketable_eng.r           - make a league table that follows the tie-breaking and points procedures for each season. 

-  maketable_all.r           - make a league table between dates or only for home/away results. 

-  games_between.r           - returns all games ever played between two teams

-  games_between_sum.r       - returns the summary of results between any two teams

-  alltimerecord.r           - returns the all time record of any team in the league

-  score_most.r              - returns the team who has been involved in the most games of each scoreline

-  score_teamX.r             - Lists all matches that a team has played in that ended in a specific scoreline

-  score_team.r              - List all occurrences of a specific scoreline for a specific team

-  scoreline_by_team.r      - How often each team has a won,lost,drawn by a scoreline? 

-  totalgoals_by_team.r     - Return all instances of a team being involved in a game with n goals

-  ngoals.r                 - Return number of times a team has scored n goals

-  n_offs.r                 - Will return the scorelines that have occurred n number of times

-  opponentfreq.r           - Return how often a team has played each opponent

-  opponents.r              - number of unique opponents for all teams in total or by tier

-  bestwins.r               - best wins for each team

-  worstlosses.r            - worst losses for each team



## What does england.csv contain?

all top 4 tier games ever played 1888-2016

- FL = Football League
- PL = Premier League

- 1888/9-1891/2   FL Division 1
- 1892/3-1914/5   FL Divisions 1 & 2
- 1919/20           FL Divisions 1 & 2
- 1920/21           FL Divisions 1, 2 & 3
- 1921/22-1938/9   FL Divisions 1, 2, 3a North & 3b South
- 1939              FL Divisions 1, 2, 3a North & 3b South (truncated season)
- 1946/7-1957/8   FL Divisions 1, 2, 3a North & 3b South
- 1958/9-1991/2   FL Divisions 1, 2, 3 & 4
- 1992/3-2004/5   PL, FL Divisions 1, 2 & 3
- 2004/5-2015/6   PL, FL Championship, FL Divisions 1 & 2
 
 In the csv file, I've used divisions 1,2,3,3a,3b, 4 as the notation
 I've also used tier 1,2,3,4  - to refer to 3,3a & 3b all belonging to tier 3

 
Dataset includes:
 
 teams that dropped out half way through a season:
 - 1919 Leeds City
 - 1931 Wigan Borough
 - 1961 Accrington Stanley

 - includes 1919 Port Vale who replaced Leeds City mid-season
 
- The truncated 1939/40 season is in a separate file england1939.csv

  Team Names used in the file are those that are currently used:
  e.g. Small Heath are Birmingham City, Ardwick are Manchester City, etc.
  
  The modern Accrington Stanley are 'Accrington' to distinguish from original Accrington Stanley and earlier Accrington FC
  



## What does facup.csv contain?

This was a pain to put together.  It contains every single FA Cup tie (whether played or not) from the first inception of the competition in 1871 to the 2015/16 season.  It does not contain pre-qualifying rounds (yet).   It is best to describe each variable name in turn to give more information:

- date         - date of match/tie
- Season       - season (e.g. 1872 refers to 1872/73 season)
- home         - home team (note for games played at neutral venues this isn't relevant)
- visitor      - visiting team (note for games played at neutral venues this isn't relevant)
- FT           - final score.  this is the final score even after extra time (i.e. not just after 90 minutes)
- hgoal        - number of goals scored by team in home variable
- vgoal        - number of goals scored by team in visitor variable
- round        - the round of the match (1,2,3,4,5,6, s = semi-final, f=final, 3pp = 3rd place playoff)
- tie          - initial = 1st game, replay = 1st replay, replay2 = 2nd replay, etc.
- aet          - whether the game went to extra time. note only 'yes' or NA. 
- pen          - whether the game went to penalties.  note only 'yes' or NA.
- pens         - the scoreline of the penalty shoot-out and who won
- hp           - penalties scored in a shoot-out by team in home variable
- vp           - penalties scored in a shoot-out by team in visitor variable
- Venue        - where match was played
- attendance   - attendance of the match
- nonmatch     - if a tie was not played, voided or a team disqualified
- notes        - further information about non-matches
- neutral      - was the game played at a neutral venue -  "yes" or NA.


Important notes to above:

I have tried to make the dataset as complete as possible.  The FA Cup data is difficult as some of it is just unobtainable.  For instance, I have added venues and attendances for all semis and finals and have included this information sporadically wherelse I was able to get it.  I have not done a systematic application of this to early rounds.   Several games in the FA Cup are played at neutral grounds or even the visiting team is allowed to play at home (e.g. if a minnow plays a big team).  I have not managed to systematically check this.   Also, there was a trend to play 2nd and 3rd and 4th replays at neutral venues.  This could be systematically checked but I have not yet.      Further, I think I have all games that ever ended in penalties added in correctly.  

Finally, team names.  There are great disputes about which teams branch off from which teams in history and who should have shared history.  I have tried to be consistent in naming teams with their most current name throughout (e.g. Millwall Rovers, Millwall Athletic and Millwall are all listed as the current name - Millwall), or the name that they used when they stopped playing (e.g. Mitchell St. George's are always listed as Birmingham St. George's).     I have also tried to follow the same team name format as in england.csv  - I think the three Accrington teams may be the only one I need to re-edit for this purpose. 



## What does playoffs.csv contain?

* all test-matches used to decide relegation/promotion between old division 1 and old division 2 1892/93 - 1897/98
* all modern playoffs used to decide relegation/promotion since 1986/87
* division of team in playoff is noted as well as the divisional playoffs each tie belongs to
* all dates of matches included



## What does spain.csv contain?

* top flight matches 1929 - 2015/16 season
* The 1929 season only took place in 1929 but is denoted as 1928 Season in keeping with the package's style format.  The 1929/30 season is noted as 1929
* Promotion/relegation matches are not included - will be in a separate csv soon
* 1979/80 season does not include "CD Málaga 0-3 UD Salamanca" match that was annulled because of match fixing
* 1979/80 season does include  "CD Málaga 0-1 AD Almería" that was not played but awarded 0-1 to AD Almería as CD Málaga failed to participate
* All team names are the currently used ones - i.e. names used during the Spanish civil war are not used.
* The 1986/87 season contains both the phase 1 round of games and the phase 2 round of games.  

Please refer to the spainliga rpubs below for further information.



## Other Leagues:

I've added complete all top tier results for Holland (1956-2017), Germany (1963-2017), Italy (1934-2017), France (1933-2017). Additionally all tier 2 results for Germany. Finally, we have results from the all tiers of Scotland, and top tier of  Belgium, Turkey, Greece, Portugal since 1994/1995.

These dataframes contain all league results played in regular season.  They don't yet include relegation/promotion playoff fixtures.  Further, I have not yet completed all final checks of the data. I believe they are error free - but if others want to test and check, I'd welcome this.




-----

Any help in improving the quality of these datasets is appreciated.



## List of Sources

- https://github.com/footballcsv/en-england  
- http://en.wikipedia.org/wiki/The_Football_League 
- http://www.rsssf.com/engpaul/fla/
- http://www.espn.co.uk/football/
- http://www.statto.com
- http://www.11v11.com
- http://www.worldfootball.net
- http://www.football-data.co.uk



## Shiny apps:
- https://jalapic.shinyapps.io/engsoccerbeta/  #based on League Data (it's a beta, there are some hiccups)
- https://jalapic.shinyapps.io/soccerteams/  #interactive ggvis chart of historical team performances
- https://jalapic.shinyapps.io/gamebygame/  #analyzing EPL teams season by season performances - using shinydashboard

## Tutorials/demos
 (note as of May 2015, the code in these may need to change to reflect the change in names of datasets and some functions)
- http://rpubs.com/jalapic/daygoals     #goal scoring trends on unqiue dates in soccer history
- http://rpubs.com/jalapic/facuplast8   #quick walkthrough of some of the FA Cup data
- http://rpubs.com/jalapic/gpg   #very quick look at id-ing breakpoints in English scoring trends
- http://rpubs.com/jalapic/gamebygame  #plotting game by game trends across seasons
- http://rpubs.com/jalapic/seasons  #visualizing season to season changes in top tier performance
- http://rpubs.com/jalapic/laliga #visualizing historical Spanish La Liga data
- http://rpubs.com/jalapic/sbs #consecutive runs by team of improved league positions



## FiveThirtyEight

Oliver Roeder and I have written several articles for fivethirtyeight using these data:

-  http://fivethirtyeight.com/features/leicester-citys-stunning-rise-in-two-charts/
-  http://fivethirtyeight.com/features/chelseas-historically-awful-start/
-  http://fivethirtyeight.com/features/the-long-migration-of-english-football/
-  http://fivethirtyeight.com/features/home-field-advantage-english-premier-league/
-  http://fivethirtyeight.com/features/in-126-years-english-football-has-seen-13475-nil-nil-draws/

Also this piece on league inequality:

- https://contexts.org/articles/english-soccers-mysterious-worldwide-popularity/


## Media Hits

(listing them here so I don't forget them)

- Dec 2014 - Profile of this dataset and me in "FourFourTwo" Magazine - https://www.scribd.com/doc/246229712/FourFourTwo-UK-2014-12

-  Mar 12th 2015  - Some research on strange results occuring in a row discussed on Guardian's Football Weekly
https://soundcloud.com/guardianfootballweekly/football-weekly-extra-chelseas-champion-league-campaign-goes-down-the-tube

- Jul 30th 2015 - Piece by Sky Sports on homefield advantage and these data -
http://www.skysports.com/football/news/11661/9829828/home-advantage-is-not-as-important-as-it-once-was-finds-sky-sports-study
 
-  Nov 28th 2015 - I discuss home-field advantage on NPR's "Only a Game" - http://onlyagame.wbur.org/2015/11/28/home-field-advantage-epl-curley

-  May 4th 2016 - I discussed this dataset and Leicester City on BBC Radio 5's "Up All Night" - unfortunately no audio - I got cut short because Ted Cruz decided to quit the Republican nomination.

- May 17th 2016 - Piece by John Murdoch at the Financial Times on Leicester City's unique season -  https://ig.ft.com/sites/leicester-premier-league-champions/

- March 10 2017 - Discussion of PSG-Barcelona 2017 Champions League tie in historical perspective (in Portuguese) - https://www.nexojornal.com.br/grafico/2017/03/10/O-que-as-bolsas-de-apostas-diziam-sobre-Barcelona-e-PSG
 







## Elsewhere

- Data in this package have been used to devise [fivethirtyeight's](https://fivethirtyeight.com/features/how-our-club-soccer-projections-work/) ratings and prediction models for soccer.

-  A number of analyses and visualizations using these data by Prof Simon Garnier - http://graphzoo.tumblr.com/

More in depth analysis by Simon on David Sumpter's Collective Behavior blog:
-  http://www.collective-behavior.com/liverpool-is-still-the-most-successful-english-club-team-but-for-how-long/
-  http://www.collective-behavior.com/how-the-big-four-made-football-predictable/

-  Prof Michael Lopez analyses home-field advantage - https://statsbylopez.com/2016/05/13/on-soccers-declining-home-field-advantage/

-  Prof Antony Unwin uses for his book "Graphical Data Analysis with R" - http://www.gradaanwr.net/wp-content/uploads/2016/05/dataApr16.pdf

- Excellent Masters Thesis in Statistics on improving FIFA rankings by Tom Van de Wiele (https://ttvand.github.io/) here - https://ttvand.github.io/MastatTomVandeWiele.pdf

- 3D visualization of team performance over years - https://vr-data-vis.herokuapp.com/engsoccerdata/index.html

- Joe Gallagher's blog post on home advantage - https://jogall.github.io/2017-05-12-home-away-pref/

- Joe Gallagher's blog post on Robin Hood teams - https://jogall.github.io/2017-08-04-robin-hood-teams/

- Andrew Clark's interactive viz of best and worst consecutive league finishes - https://www.mytinyshinys.com/2017/08/04/socceriimprovers/

- Ryan Estrellado's analysis of Liverpool FC Managers - https://restrellado.github.io/liverpoolfc/lfc_managers.html
& https://ryanestrellado.netlify.com/post/lfc-home-and-away-odds/

-  Austin Wehrwein's modeling of soccer results - http://austinwehrwein.com/soccer/



### Acknowledgements

Hakon Malmedal
Joe Gallagher
Ben Dilday
Aaron Smith
Michael Thompson
Andrew Clark
S'busiso Mkhondwane
