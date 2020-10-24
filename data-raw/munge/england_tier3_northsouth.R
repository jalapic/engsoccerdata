

### some division issues 1930s England

head(england)

table(england[is.na(england$division),]$tier)

table(england[is.na(england$division),]$Season)

# 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1946 1947 1948 1949 1950 1951 1952
# 842  842  924  924  924  924  924  924  924  924  894  924  924  924  924  924  924  924  924  924  924  924 1104 1104 1104
# 1953 1954 1955 1956 1957
# 1104 1104 1104 1104 1104


#1921-->1957  tier 3 divisions fail.


# each year .... pick a team in N or S, find opponents, get all in that year, and add in division?

england %>% filter(tier==3 & Season==1923)  #Stockport County North,

###

england %>% filter(tier==3 & Season==1957 & home=="Scunthorpe United") %>% .$visitor -> tms
tms <- c(tms, "Scunthorpe United")
tms

# england$division <- ifelse(england$Season==1921 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1922 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1923 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1924 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1925 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1926 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1927 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1928 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1929 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1930 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1931 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1932 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1933 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1934 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1935 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1936 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1937 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1938 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1946 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1947 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1948 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1949 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1950 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1951 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1952 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1953 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1954 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1955 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1956 & england$home %in% tms, "3N", "3S")
#england$division <- ifelse(england$Season==1957 & england$home %in% tms, "3N", "3S")


## update steps
usethis::use_data(england, overwrite = T)
write.csv(england,'data-raw/england.csv',row.names=F)
devtools::load_all()

dim(england)

#update current

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()

