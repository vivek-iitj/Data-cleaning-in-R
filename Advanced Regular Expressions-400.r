## 1. Introduction ##

library(stringr)
library(readr)

hn  <-  read_csv("hacker_news.csv")
titles  <-  hn$title
sql_pattern<-"(?i)SQL"
sql_counts<-sum(str_detect(titles,sql_pattern))