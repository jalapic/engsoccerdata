####  Home goal differential per game compared to Away goal differential per game

df<-read.csv("engsoccerdata.csv") #contains results/goals scored/conceded for all top 4 tier games 1888-2014
teams<-read.csv("engsoccerteams.csv") #contains data on teams and if in league 2013-4.

library(dplyr)
library(tidyr)
x<-df %>%
  group_by(home) %>%
  mutate (GF.home = sum(hgoal), GA.home = sum(vgoal)) %>%
  select (team=home,GF.home,GA.home) %>%  #new=old
  do(head(.,1))  #this line should removes duplicates 

n.games <-df %>% 
  group_by(home) %>% 
  select(team=home) %>%
  tally 

temp<- n.games %>%
  inner_join(x) %>%
  mutate(GFhome.pg = GF.home/n, GAhome.pg = GA.home/n, GDhome.pg = GFhome.pg-GAhome.pg)

x1<-df %>%
  group_by(visitor) %>%
  mutate (GF.away = sum(vgoal), GA.away = sum(hgoal)) %>%
  select (team=visitor,GF.away,GA.away) %>%
  do(head(.,1)) 

temp<- temp %>%
  inner_join(x1)%>%
  mutate(GFaway.pg = GF.away/n, GAaway.pg = GA.away/n, GDaway.pg = GFaway.pg-GAaway.pg)


tempdf<-as.data.frame((temp))
tempdf


tempdf<-tempdf%>%
  inner_join(teams)  #this merges two dfs, adding col with current2013 yes/no in it

#simple plot
plot(x$GDhome.pg, x$GDaway.pg)  #could do plot by currently in league vs not currently in league


library(ggplot2)

#theme2 - from my personal list of themes
theme2<-theme(panel.background = element_rect(fill='transparent'), 
              panel.grid.minor = element_line(color='transparent'),
              axis.text = element_text (size=15, color="grey11"),
              axis.title = element_text(color = 'grey11', size = 20),
              plot.title = element_text(size=24),
              axis.line = element_line(size = 0.5, color = "gray39"),
              strip.text = element_text(color = 'black', size = 15),
              panel.grid.major = element_line(colour = "gray99"),
              panel.grid.minor = element_blank())




p<-ggplot(tempdf, aes(x=GDhome.pg, y=GDaway.pg)) +   
  geom_point(aes(colour = factor(current2013)), size = 4) +
  theme2 +
  scale_color_manual(values = c("orange", "purple")) +
  xlab("Home Goal Differential Per Game") +
  ylab("Away Goal Differential Per Game") +
  geom_hline(yintercept=0, color="red", lty=3) +
  geom_vline(xintercept=0, color="red", lty=3)
p   

#couple of ways to sort table
tempdf %>% arrange(desc(GDaway.pg))
tempdf %>% arrange(GDhome.pg)



