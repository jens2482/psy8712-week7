# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)



# Data Import and Cleaning
week7_tbl <- read_csv ("../data/week3.csv") %>%
  mutate(timeStart = ymd_hms (timeStart)) %>%
  mutate(timeEnd = ymd_hms (timeEnd)) %>%
  mutate(condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control"))) %>%
  mutate(gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female"))) %>%
  filter(q6 == 1) %>%
  select(-q6) %>%
  mutate(timeSpent = difftime(timeEnd, timeStart, units = "mins"))




# Visualization
{week7_tbl %>% 
    ggpairs(columns = 5:13,lower = list(continuous = "points"), diag = list(continuous = "densityDiag"), upper = list(continuous = "cor"))} %>%
  ggsave(filename = "../figs/fig0.png", ., height=5, width=10, dpi=600) #unclear whether or not this needed to be saved as a figure; did just in case as fig0
{week7_tbl %>% 
    ggplot(aes(timeStart, q1))+
    geom_point()+
    xlab("Date of Experiment")+
    ylab("Q1 Score")} %>%
  ggsave(filename = "../figs/fig1.png", ., height=3, width=6, units="in", dpi=600)
{week7_tbl %>%  
    ggplot(aes(q1,q2, color = gender))+
    geom_jitter()+
    labs(color = "Participant Gender")} %>%
  ggsave(filename = "../figs/fig2.png", ., height=3, width=6, units="in", dpi=600)
{week7_tbl %>%  
    ggplot(aes(q1,q2))+
    geom_jitter()+
    facet_wrap(~gender) +    
  xlab("Score on Q1")+
    ylab("Score on Q2")} %>%
  ggsave(filename = "../figs/fig3.png", ., height=3, width=6, units="in", dpi=600)
  
