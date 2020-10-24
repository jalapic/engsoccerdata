

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

# full time in 3N / 3S  1921-1957
###  Brighton & Hove Albion....  3S
###  Hartlepool United....  3N


c(england %>% filter(tier==3 & Season==1921 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms21
c(england %>% filter(tier==3 & Season==1922 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms22
c(england %>% filter(tier==3 & Season==1923 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms23
c(england %>% filter(tier==3 & Season==1924 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms24
c(england %>% filter(tier==3 & Season==1925 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms25
c(england %>% filter(tier==3 & Season==1926 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms26
c(england %>% filter(tier==3 & Season==1927 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms27
c(england %>% filter(tier==3 & Season==1928 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms28
c(england %>% filter(tier==3 & Season==1929 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms29
c(england %>% filter(tier==3 & Season==1930 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms30
c(england %>% filter(tier==3 & Season==1931 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms31
c(england %>% filter(tier==3 & Season==1932 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms32
c(england %>% filter(tier==3 & Season==1933 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms33
c(england %>% filter(tier==3 & Season==1934 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms34
c(england %>% filter(tier==3 & Season==1935 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms35
c(england %>% filter(tier==3 & Season==1936 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms36
c(england %>% filter(tier==3 & Season==1937 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms37
c(england %>% filter(tier==3 & Season==1938 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms38
c(england %>% filter(tier==3 & Season==1946 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms46
c(england %>% filter(tier==3 & Season==1947 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms47
c(england %>% filter(tier==3 & Season==1948 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms48
c(england %>% filter(tier==3 & Season==1949 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms49
c(england %>% filter(tier==3 & Season==1950 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms50
c(england %>% filter(tier==3 & Season==1951 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms51
c(england %>% filter(tier==3 & Season==1952 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms52
c(england %>% filter(tier==3 & Season==1953 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms53
c(england %>% filter(tier==3 & Season==1954 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms54
c(england %>% filter(tier==3 & Season==1955 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms55
c(england %>% filter(tier==3 & Season==1956 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms56
c(england %>% filter(tier==3 & Season==1957 & home=="Hartlepool United") %>% .$visitor, "Hartlepool United")-> tms57


england$division <- ifelse(england$Season==1921 & england$home %in% tms21, "3N", england$division)
england$division <- ifelse(england$Season==1922 & england$home %in% tms22, "3N", england$division)
england$division <- ifelse(england$Season==1923 & england$home %in% tms23, "3N", england$division)
england$division <- ifelse(england$Season==1924 & england$home %in% tms24, "3N", england$division)
england$division <- ifelse(england$Season==1925 & england$home %in% tms25, "3N", england$division)
england$division <- ifelse(england$Season==1926 & england$home %in% tms26, "3N", england$division)
england$division <- ifelse(england$Season==1927 & england$home %in% tms27, "3N", england$division)
england$division <- ifelse(england$Season==1928 & england$home %in% tms28, "3N", england$division)
england$division <- ifelse(england$Season==1929 & england$home %in% tms29, "3N", england$division)
england$division <- ifelse(england$Season==1930 & england$home %in% tms30, "3N", england$division)
england$division <- ifelse(england$Season==1931 & england$home %in% tms31, "3N", england$division)
england$division <- ifelse(england$Season==1932 & england$home %in% tms32, "3N", england$division)
england$division <- ifelse(england$Season==1933 & england$home %in% tms33, "3N", england$division)
england$division <- ifelse(england$Season==1934 & england$home %in% tms34, "3N", england$division)
england$division <- ifelse(england$Season==1935 & england$home %in% tms35, "3N", england$division)
england$division <- ifelse(england$Season==1936 & england$home %in% tms36, "3N", england$division)
england$division <- ifelse(england$Season==1937 & england$home %in% tms37, "3N", england$division)
england$division <- ifelse(england$Season==1938 & england$home %in% tms38, "3N", england$division)
england$division <- ifelse(england$Season==1946 & england$home %in% tms46, "3N", england$division)
england$division <- ifelse(england$Season==1947 & england$home %in% tms47, "3N", england$division)
england$division <- ifelse(england$Season==1948 & england$home %in% tms48, "3N", england$division)
england$division <- ifelse(england$Season==1949 & england$home %in% tms49, "3N", england$division)
england$division <- ifelse(england$Season==1950 & england$home %in% tms50, "3N", england$division)
england$division <- ifelse(england$Season==1951 & england$home %in% tms51, "3N", england$division)
england$division <- ifelse(england$Season==1952 & england$home %in% tms52, "3N", england$division)
england$division <- ifelse(england$Season==1953 & england$home %in% tms53, "3N", england$division)
england$division <- ifelse(england$Season==1954 & england$home %in% tms54, "3N", england$division)
england$division <- ifelse(england$Season==1955 & england$home %in% tms55, "3N", england$division)
england$division <- ifelse(england$Season==1956 & england$home %in% tms56, "3N", england$division)
england$division <- ifelse(england$Season==1957 & england$home %in% tms57, "3N", england$division)

#############


c(england %>% filter(tier==3 & Season==1921 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms21
c(england %>% filter(tier==3 & Season==1922 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms22
c(england %>% filter(tier==3 & Season==1923 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms23
c(england %>% filter(tier==3 & Season==1924 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms24
c(england %>% filter(tier==3 & Season==1925 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms25
c(england %>% filter(tier==3 & Season==1926 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms26
c(england %>% filter(tier==3 & Season==1927 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms27
c(england %>% filter(tier==3 & Season==1928 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms28
c(england %>% filter(tier==3 & Season==1929 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms29
c(england %>% filter(tier==3 & Season==1930 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms30
c(england %>% filter(tier==3 & Season==1931 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms31
c(england %>% filter(tier==3 & Season==1932 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms32
c(england %>% filter(tier==3 & Season==1933 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms33
c(england %>% filter(tier==3 & Season==1934 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms34
c(england %>% filter(tier==3 & Season==1935 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms35
c(england %>% filter(tier==3 & Season==1936 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms36
c(england %>% filter(tier==3 & Season==1937 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms37
c(england %>% filter(tier==3 & Season==1938 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms38
c(england %>% filter(tier==3 & Season==1946 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms46
c(england %>% filter(tier==3 & Season==1947 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms47
c(england %>% filter(tier==3 & Season==1948 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms48
c(england %>% filter(tier==3 & Season==1949 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms49
c(england %>% filter(tier==3 & Season==1950 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms50
c(england %>% filter(tier==3 & Season==1951 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms51
c(england %>% filter(tier==3 & Season==1952 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms52
c(england %>% filter(tier==3 & Season==1953 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms53
c(england %>% filter(tier==3 & Season==1954 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms54
c(england %>% filter(tier==3 & Season==1955 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms55
c(england %>% filter(tier==3 & Season==1956 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms56
c(england %>% filter(tier==3 & Season==1957 & home=="Brighton & Hove Albion") %>% .$visitor, "Brighton & Hove Albion")-> tms57




england$division <- ifelse(england$Season==1921 & england$home %in% tms21, "3S", england$division)
england$division <- ifelse(england$Season==1922 & england$home %in% tms22, "3S", england$division)
england$division <- ifelse(england$Season==1923 & england$home %in% tms23, "3S", england$division)
england$division <- ifelse(england$Season==1924 & england$home %in% tms24, "3S", england$division)
england$division <- ifelse(england$Season==1925 & england$home %in% tms25, "3S", england$division)
england$division <- ifelse(england$Season==1926 & england$home %in% tms26, "3S", england$division)
england$division <- ifelse(england$Season==1927 & england$home %in% tms27, "3S", england$division)
england$division <- ifelse(england$Season==1928 & england$home %in% tms28, "3S", england$division)
england$division <- ifelse(england$Season==1929 & england$home %in% tms29, "3S", england$division)
england$division <- ifelse(england$Season==1930 & england$home %in% tms30, "3S", england$division)
england$division <- ifelse(england$Season==1931 & england$home %in% tms31, "3S", england$division)
england$division <- ifelse(england$Season==1932 & england$home %in% tms32, "3S", england$division)
england$division <- ifelse(england$Season==1933 & england$home %in% tms33, "3S", england$division)
england$division <- ifelse(england$Season==1934 & england$home %in% tms34, "3S", england$division)
england$division <- ifelse(england$Season==1935 & england$home %in% tms35, "3S", england$division)
england$division <- ifelse(england$Season==1936 & england$home %in% tms36, "3S", england$division)
england$division <- ifelse(england$Season==1937 & england$home %in% tms37, "3S", england$division)
england$division <- ifelse(england$Season==1938 & england$home %in% tms38, "3S", england$division)
england$division <- ifelse(england$Season==1946 & england$home %in% tms46, "3S", england$division)
england$division <- ifelse(england$Season==1947 & england$home %in% tms47, "3S", england$division)
england$division <- ifelse(england$Season==1948 & england$home %in% tms48, "3S", england$division)
england$division <- ifelse(england$Season==1949 & england$home %in% tms49, "3S", england$division)
england$division <- ifelse(england$Season==1950 & england$home %in% tms50, "3S", england$division)
england$division <- ifelse(england$Season==1951 & england$home %in% tms51, "3S", england$division)
england$division <- ifelse(england$Season==1952 & england$home %in% tms52, "3S", england$division)
england$division <- ifelse(england$Season==1953 & england$home %in% tms53, "3S", england$division)
england$division <- ifelse(england$Season==1954 & england$home %in% tms54, "3S", england$division)
england$division <- ifelse(england$Season==1955 & england$home %in% tms55, "3S", england$division)
england$division <- ifelse(england$Season==1956 & england$home %in% tms56, "3S", england$division)
england$division <- ifelse(england$Season==1957 & england$home %in% tms57, "3S", england$division)




#########

## update steps
usethis::use_data(england, overwrite = T)
write.csv(england,'data-raw/england.csv',row.names=F)
devtools::load_all()

dim(england)

#update current

# redo documentation   devtools::document()
devtools::load_all()

devtools::document()




####

df <- england %>% filter(tier==3) %>% filter(Season>1920 & Season<1957)
head(df)
tail(df)

df %>% filter(home=="Brighton & Hove Albion")

df$division <- ifelse(df$home=="Brighton & Hove Albion" | df$visitor=="Brighton & Hove Albion", "3S", "3N")

head(df)
tail(df)
