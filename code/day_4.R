# day 4 
# 12/4/22

library(tidyverse)

input <- read_csv('/Users/caroline.buck/Desktop/Fun_R/advent-of-code-2022/input/day_4.csv')

# part 1: find when elf assignments completely overlap 
input %>%
  separate(sections,into=c('elf1_lower','elf1_upper','elf2_lower','elf2_upper')) %>%
  mutate_if(is.character,as.numeric) %>%
  mutate(elf_overlap = case_when(
    elf1_lower >= elf2_lower & elf1_upper <= elf2_upper ~ 'overlap', # elf1 inside
    elf1_lower <= elf2_lower & elf1_upper >= elf2_upper ~ 'overlap', # elf2 inside 
    TRUE ~ 'not fully overlapping'
  )) %>%
  count(elf_overlap)
  

# part 2: find any bit of overlap assignments
input %>%
  separate(sections,into=c('elf1_lower','elf1_upper','elf2_lower','elf2_upper')) %>%
  mutate_if(is.character,as.numeric) %>%
  mutate(elf_overlap = case_when(
    elf1_lower > elf2_upper ~ 'no overlap', 
    elf1_upper < elf2_lower ~ 'no overlap',  
    TRUE ~ 'overlap'
  )) %>%
  count(elf_overlap)

#1 3   4 5 if upper1 is less than lower2 ~ true, no overlap
#4 5   1 3 if lower1 is greater than upper2 ~ true, no overlap
