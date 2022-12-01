## Advent of code 2022
# day 1: 12/1/22

library(tidyverse)

# part 1: find num of calories carried by elf w/ most calories
input <- read_csv('/Users/caroline.buck/Desktop/Fun_R/advent-of-code-2022/input/day_1.csv',skip_empty_rows = FALSE) %>%
  # add extra row so will get the elf id properly
  add_row(calories = NA,.before=1)
input$elf <- NA

# add id value if calories is NA
id = 1
for (x in 1:2249) {
  if(is.na(input$calories[x])){
    input$elf[x] <- id
    id <- id+1
  }
}

# fill down elf id, then filter out NA calorie rows, group by elf, sum calories, get num of calories for elf w/ the most
input %>%
  fill(elf,.direction='down') %>%
  filter(!is.na(calories)) %>%
  group_by(elf) %>%
  summarise(total_cal = sum(calories)) %>%
  arrange(desc(total_cal)) %>%
  slice(1)
  
# elf w/ most calories: elf 13
# num calories: 67027

# part two: find total calories for top three elves
input %>%
  fill(elf,.direction='down') %>%
  filter(!is.na(calories)) %>%
  group_by(elf) %>%
  summarise(total_cal = sum(calories)) %>%
  arrange(desc(total_cal)) %>%
  slice(1:3) %>%
  summarise(total_cal = sum(total_cal))

# total calories by top 3: 197291