#### TOP 4 TIER ENGLISH LEAGUE SOCCER GAMES 1888-2014  ####


engsoccerdata
=============

### Compiled by James Curley July 2014


Free to use for non-commerical use.   

If you do use it on any publications, blogs, websites, etc. 
please note the source (i.e. me!)

Also, if you do use it - I would love to see any analysis 
produced from it etc.



# My plan is to convert these functions/data into a R package
  in the not too distant future  

- if you'd like to get involved and help out, please let me know.  
- Also, if you can see better ways of writing the R code, please let me know.

Contact details:   jc3181  AT columbia DOT edu



# What this repository contains:


# Datasets
-  engsoccerdata.csv   - Results of all top 4 tier soccer games in England 1888-2014
-  engsoccerteams.csv  - file containing list of 142 teams plus whether they were in
                         the top 4 divisions in 2013/4


# Functions

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



#What does engsoccerdata.csv contain?

all top 4 tier games ever played 1888-2014
 
- FL = Football League
- PL = Premier League
 
- 1888/9 - 1891/2   FL Division 1
- 1892/3 - 1914/5   FL Divisions 1 & 2
- 1919/20           FL Divisions 1 & 2
- 1920/21           FL Divisions 1, 2 & 3
- 1921/22- 1938/9   FL Divisions 1, 2, 3a North & 3b South
- 1939              FL Divisions 1, 2, 3a North & 3b South (truncated season)
- 1946/7 - 1957/8   FL Divisions 1, 2, 3a North & 3b South
- 1958/9 - 1991/2   FL Divisions 1, 2, 3 & 4
- 1992/3 - 2004/5   PL, FL Divisions 1, 2 & 3
- 2004/5 - 2013/4   PL, FL Championship, FL Divisions 1 & 2
 
 In the csv file, I've used divisions 1,2,3,3a,3b, 4 as the notation
 I've also used tier 1,2,3,4  - to refer to 3,3a & 3b all belonging to tier 3

 
# Dataset includes:
 
 teams that dropped out half way through a season: 
 - 1919 Leeds City
 - 1931 Wigan Borough
 - 1961 Accrington Stanley 

 - includes 1919 Port Vale who replaced Leeds City mid-season
 - includes: truncated 1938 season
 
 - from 1993-2014, includes date of game.
 - games before 1993 only have Season.
 
 - Season refers to the first year of that season e.g. 1952/3 would be "1952"

  Team Names used in the file are those that are currently used:
  e.g. Small Heath are Birmingham City, Ardwick are Manchester City, etc.
  
  The modern Accrington Stanley are 'Accrington' to distinguish from original Accrington Stanley and earlier Accrington FC
  
    



# Important Note

I cannot 100% guarantee the accuracy of every result.  I have checked very thouroughly for mistakes etc., but as this dataset was collected from multiple sources, there is a chance for the odd error.  -  If you find an error, let me know and I will fix asap.   




# List of Sources

- This was mainly put together through much web-scraping from wikipedia  (code available on request)

- https://github.com/footballcsv/en-england  (post 1992 data including dates)
- http://en.wikipedia.org/wiki/The_Football_League  (everything else)
- http://www.rsssf.com/engpaul/fla/ (source for most of wikipedia data)
- http://www.espn.co.uk/football/  (1980s missing seasons)






