## 1. Analyzing New York City Public Schools Data ##

library(readr)
library(dplyr)
combined<-read_csv("combined.csv")
combined<-combined %>% select(-SchoolName,-`SCHOOL NAME.y`,-Name,-`School Name`,-school_name,-`Location 1`) %>%
rename(school_name=`SCHOOL NAME.x`)

## 2. Visualizing Relationships Between Variables Using Scatter Plots ##

library(ggplot2)
ggplot(data=combined) + 
aes(x=frl_percent,y=avg_sat_score) + 
geom_point()

ggplot(data=combined) + 
aes(x=ell_percent,y=avg_sat_score) + 
geom_point()

ggplot(data=combined) + 
aes(x=sped_percent,y=avg_sat_score) +
geom_point()

## 4. Pivoting a Dataframe into a Longer One ##

combined_race_longer<- combined %>% 
pivot_longer(cols=c(asian_per,black_per,hispanic_per,white_per),
             names_to="race",
             values_to="percent")

ggplot(data=combined_race_longer) + 
aes(x=percent,y=avg_sat_score,color=race) + 
geom_point()

## 5. Pivoting a Dataframe into a Wider One ##

combined_race_wider<-combined_race_longer %>% 
pivot_wider(names_from=race,
            values_from=percent)

## 7. Correlation Analysis: Measuring the Strength of Relationships Between Variables ##

coeff<-cor(combined$asian_per,combined$avg_sat_score,use="pairwise.complete.obs")
round(coeff,7)

## 8. Creating and Interpreting Correlation Matrices ##

cor_mat<-combined %>% 
select_if(is.numeric) %>% 
cor(use="pairwise.complete.obs")

## 9. Identifying Interesting Relationships ##

cor_tib <- cor_mat %>%
  as_tibble(rownames = "variable")

apscore_cors<- cor_tib %>% 
select(variable,high_score_percent) %>% 
filter(high_score_percent>.25 | high_score_percent< -0.25)