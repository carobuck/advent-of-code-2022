# day 3

# part 1
library(tidyverse)
#install.packages("comprehenr") # for py-style list comprehensions
library(comprehenr)

knapsack <- read_csv('/Users/caroline.buck/Desktop/Fun_R/advent-of-code-2022/input/day_3.csv')

knapsack %>%
  mutate(midway_pt = str_length(input)/2,
         str1 = str_sub(input,1,midway_pt),
         str2 = str_sub(input,midway_pt + 1)) -> test #,
         # this didn't quite work, so going with the janky stuff down below. might work w/ more fiddling
         #str1_split = str_split(str1,boundary("character")),
         #dup_letter = to_vec(for(letter in str1_split[[1]]) if(str_detect(test$str2[i],letter)) letter)[1]) %>%


dupe_letter <- c()
for(i in 1:300){
  split_str <- str_split(test$str1[i],boundary("character"))
  #print(split_str[[1]])
  temp <- to_vec(for(letter in split_str[[1]]) if(str_detect(test$str2[i],letter)) letter) 
  print(temp[1]) # take the first thing, sometimes the letter is found more than once in second string
  dupe_letter[i] <- temp[1]
}

test$dupe_letter <- dupe_letter

# get priorities of 'items'
#Lowercase item types a through z have priorities 1 through 26.
#Uppercase item types A through Z have priorities 27 through 52.
test %>%
  mutate(priority = case_when(
    str_detect(dupe_letter,"[[:upper:]]") ~ as.character(match(str_to_upper(dupe_letter), LETTERS)+26),
    str_detect(dupe_letter,"[[:lower:]]") ~ as.character(match(str_to_upper(dupe_letter), LETTERS)),
    TRUE ~ 'kdfkd'
  )) %>%
  summarise(total_priority = sum(as.numeric(priority)))

# 8515

## part 2 --
# repeat 1,2,3.. down the df
# need to pivot wider to 1,2,3...
# for letters in str1, (strdetect in str2 && str3)
# then get priority for letters
# sum priority 
knapsack %>%
  mutate(elf = rep(c(1,2,3),100)) %>%
  pivot_wider(values_from = input,names_from = elf) %>%
  head
  
## dumping ground code 
"p" %in% "hPhbpfWzfbwfPmpprb"

str_detect("hPhbpfWzfbwfPmpprb","p")
to_vec(for(x in colours) for(y in things) paste(x, y))
to_vec(for (x in 2:99) if(!x %in% noprimes) x)
to_vec(for(letter in str1) if(letter %in% str2) letter)


# this would work well w/ py list comprehension??
# [letter for (letters in str1) if letter in str2]

# or use this pkg?? https://cran.r-project.org/web/packages/comprehenr/vignettes/Introduction.html

for(letter in test$str1[1]) {
  print(letter)
}
numerate(letters)

# think I need these str1 and str2 in a list/multiple strings not single string to iterate through??
# or iterate through a string?? know how to do this in python... use: str_split(numberstring,boundary("character")) ??
