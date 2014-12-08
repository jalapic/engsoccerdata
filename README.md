#### engsoccerdata

This R package is mainly a repository for complete soccer datasets, along with some built-in functions for analyzing parts of the data. Currently I include two English ones (described below). Updates in the near future will include those for various European leagues as well as MLS. 

Free to use for non-commerical use.   Compiled by James Curley July - Dec 2014

Please cite as:  
James P. Curley (2014). engsoccerdata: English Soccer Data 1871-2014. R package version 0.1.2 [![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.13158.svg)](http://dx.doi.org/10.5281/zenodo.13158)

If you do use it on any publications, blogs, websites, etc. please note the source (i.e. me!).  Also, if you do use it - I would love to see any analysis produced from it etc.  Of course, I accept no responsibility for any error that may be contained herewithin.

- if you'd like to get involved and help out, please let me know.  
- Also, if you can see better ways of writing the R code, please let me know.

Contact details:   jc3181  AT columbia DOT edu

Thanks to Hakon Malmedal for assistance in turning this project into an R package.


### Installation

To install this directly into R.

```
library(devtools)
install_github('jalapic/engsoccerdata', username = "jalapic")
library(engsoccerdata)

data(package="engsoccerdata")    # lists datasets currently available
df = engsoccerdata2  # this is the main dataset for English league data.
df = facup  # this is the main dataset for English FA Cup data

```





engsoccerdata
=============

Last update: 2nd Dec 2014,  v1.0.2 


## Datasets
-  engsoccerdata2.csv   - Results of all top 4 tier soccer games in England 1888-2014
-  engsoccerteams.csv  - file containing list of 142 teams plus whether they were in
                         the top 4 divisions in 2013/4

- facup.csv             - Contains all FA Cup ties (not including pre-qualifying rounds) 1871-2014
- facupteams.csv        - Contains all teams in facup.csv along with first year and most recent year

- playoffs.csv          - Incldues 'test-matches' 1892-1897 and modern playoffs (1986/87 onwards)




## Functions 

These work best for League Data.

-  makingtables.r           - some dplyr scripts to make league tables for each season

-  soccercode.r             - using dplyr and ggplot2 to look at goal differentials
                              per game per team 

-  namecheck.r              - function to look up if characters exist in a team name

-  games_between.r          - returns all games ever played between two teams

-  games_between.summary.r  - returns the summary of results between any two teams

-  alltimerecord.r          - returns the all time record of any team in the league

-  goals_by_team.r          - Return all instances of a team scoring n goals

-  score_most.r             - returns the team who has been involved in the most 
                              games of each scoreline

-  score_team.all.r         - Lists all matches that a team has played in that ended
                              in a scoreline

-  score_team.r             - List all occurrences of a specific scoreline for a 
                              specific team

-  scoreline_by_team.r      - How often each team has a won,lost,drawn by a scoreline? 

-  totalgoals_by_team.r     - Return all instances of a team being involved in a game
                              with n goals

-  n_offs.r                 - Will return the scorelines that have occurred n number 
                              of times

-  opponentfreq.r           - Return how often a team has played each opponent

-  games_by_tier.r          - computes number of games played by tier per team

-  seasons_by_tier.r        - computes number of seasons spent per tier per team

-  opponents.r              - number of unique opponents for all teams in total or by tier

-  bestwins.r               - best wins for each team

-  worstlosses.r            - worst losses for each team




## What does engsoccerdata2.csv contain?

all top 4 tier games ever played 1888-2014


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
- 2004/5-2013/4   PL, FL Championship, FL Divisions 1 & 2
 
 In the csv file, I've used divisions 1,2,3,3a,3b, 4 as the notation
 I've also used tier 1,2,3,4  - to refer to 3,3a & 3b all belonging to tier 3

 
Dataset includes:
 
 teams that dropped out half way through a season:
 - 1919 Leeds City
 - 1931 Wigan Borough
 - 1961 Accrington Stanley

 - includes 1919 Port Vale who replaced Leeds City mid-season
 - includes: truncated 1939/40 season

  Team Names used in the file are those that are currently used:
  e.g. Small Heath are Birmingham City, Ardwick are Manchester City, etc.
  
  The modern Accrington Stanley are 'Accrington' to distinguish from original Accrington Stanley and earlier Accrington FC
  

Important Note:

I cannot 100% guarantee the accuracy of every result.  I have checked very thouroughly for mistakes etc., but as this dataset was collected from multiple sources, there is a chance for the odd error.  -  If you find an error, let me know and I will fix asap.   

Note on Sep 28th 2014, I have completed more checks and fixed some errors.
Note on Nov 26th 2014, I have completed more checks and fixed some errors and added dates for every fixture.



## What does facup.csv contain?

This was a pain to put together.  It contains every single FA Cup tie (whether played or not) from the first inception of the competition in 1871 to the 2013/14 season.  It does not contain pre-qualifying rounds (yet).   It is best to describe each variable name in turn to give more information:

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

Finally, team names.  There are great disputes about which teams branch off from which teams in history and who should have shared history.  I have tried to be consistent in naming teams with their most current name throughout (e.g. Millwall Rovers, Millwall Athletic and Millwall are all listed as the current name - Millwall), or the name that they used when they stopped playing (e.g. Mitchell St. George's are always listed as Birmingham St. George's).     I have also tried to follow the same team name format as in engsoccerdata2.csv  - I think the three Accrington teams may be the only one I need to re-edit for this purpose. 


## What does playoffs.csv contain?

* all test-matches used to decide relegation/promotion between old division 1 and old division 2 1892/93 - 1897/98
* all modern playoffs used to decide relegation/promotion since 1986/87
* division of team in playoff is noted as well as the divisional playoffs each tie belongs to
* all dates of matches included





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




## Tutorials/demos

- http://rpubs.com/jalapic/daygoals     #goal scoring trends on unqiue dates in soccer history
- http://rpubs.com/jalapic/facuplast8   #quick walkthrough of some of the FA Cup data
- http://rpubs.com/jalapic/gpg   #very quick look at id-ing breakpoints in English scoring trends 
