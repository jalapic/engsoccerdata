#### Some example scripts of how to make League Tables from Raw Data

df <- engsoccerdata2



library(dplyr)

homes <- df %>%
  group_by(Season,division,home) %>%
  summarise(homeGP=n(), homeW=sum(result=="H"), homeD=sum(result=="D"), homeL=sum(result=="A"),
            homeGF=sum(hgoal), homeGA=sum(vgoal), homeGD=sum(goaldif))

aways <- df %>%
  group_by(Season,division,visitor) %>%
  summarise(awayGP=n(), awayW=sum(result=="A"), awayD=sum(result=="D"), awayL=sum(result=="H"),
            awayGF=sum(vgoal), awayGA=sum(hgoal), awayGD=sum(-goaldif)) 


tables <- cbind(homes,aways)
tables <- tables[c(1:10,14:20)]
colnames(tables)[3]<-"team"



### Points were 2 for a win until 1981/2 season

tables2pts <- tables %>% filter(Season<=1980)
tables3pts <- tables %>% filter(Season>=1981)

tables2pts <- tables2pts %>% 
          mutate(GP=homeGP+awayGP, W=homeW+awayW, D=homeD+awayD, L=homeL+awayL, GF=homeGF+awayGF, 
                 GA=homeGA+awayGA, GD=homeGD+awayGD, Pts=(W*2)+(D*1)) %>% 
          group_by(Season,division) %>% 
          arrange(desc(Pts), desc(GD), desc(GF))

tables3pts <- tables3pts %>% 
  mutate(GP=homeGP+awayGP, W=homeW+awayW, D=homeD+awayD, L=homeL+awayL, GF=homeGF+awayGF, 
         GA=homeGA+awayGA, GD=homeGD+awayGD, Pts=(W*3)+(D*1)) %>% 
  group_by(Season,division) %>% 
  arrange(desc(Pts), desc(GD), desc(GF))

tables <- rbind(tables2pts,tables3pts)

tables$seasondiv <- paste(tables$Season,tables$division,sep="-")



# Split into individual tables e.g. just to look at totals

tables1 <- tables %>% select(Season, division, team, GP, W, D, L, GF, GA, GD, Pts, seasondiv) %>%
                      group_by(Season,division) %>%
                      arrange(Season,division,desc(Pts),desc(GD),desc(GF))

head(tables1)

## get an index to use as a reference for list output
index<- tables1 %>% 
        select(seasondiv) %>% 
        group_by(seasondiv) %>% 
        filter(row_number() == 1) 

index <- as.data.frame(index) %>% mutate(index = row_number(seasondiv))

index #the index column will give you which element of the list to return (see below)

mylist <- split(tables1, tables1$seasondiv)

mylist[[1]] #1888 tier 1
mylist[[391]] #2010  tier 4 (i.e. League 2 as is now called)
mylist[[206]]  #1964 tier 3

#### Note these tables obviously do not include point penalties
## e.g. 2010 tier 4 - Hereford were deducted 3 points for fielding an ilegible player.

