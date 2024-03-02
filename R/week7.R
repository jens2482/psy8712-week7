# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)




# Data Import and Cleaning
timeSpent <- read_csv ("../data/week3.csv") %>%
  mutate(timeStart = ymd_hms (timeStart)) %>%
  mutate(timeEnd = ymd_hms (timeEnd)) %>%
  mutate(condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control"))) %>%
  mutate(gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female"))) %>%
  filter(q6 == 1) %>%
  select(-q6) %>%
  mutate(timeSpent = difftime(timeEnd, timeStart, units = "mins"))



