# day 2 input 
# rock paper scissors w/ elves

# part 1
library(tidyverse)

# rock = A X ( 1pt)
# paper = B Y (2 pt)
# scissors = C Z ( 3pt)s
strat <- read_csv('/Users/caroline.buck/Desktop/Fun_R/advent-of-code-2022/input/day_2.csv')
strat %>%
  separate(input,into = c('player1','player2'))%>%
  mutate(outcome = case_when(
           # draw (3 pts)
           player1 == 'A' & player2 == 'X' ~ '3 1',
           player1 == 'B' & player2 == 'Y' ~ '3 2',
           player1 == 'C' & player2 == 'Z' ~ '3 3',
           # player 1 win (0 points)
           player1 == 'A' & player2 == 'Z' ~ '0 3',
           player1 == 'B' & player2 == 'X' ~ '0 1',
           player1 == 'C' & player2 == 'Y' ~ '0 2',
           # player 2 win (6 pts)
           player1 == 'C' & player2 == 'X' ~ '6 1',
           player1 == 'A' & player2 == 'Y' ~ '6 2',
           player1 == 'B' & player2 == 'Z' ~ '6 3',
    TRUE ~ 'none' # note that this can't be NA (needs to be char) otherwise error in case_when
  )) %>%
  separate(outcome, into = c('score','shape')) %>%
  mutate(roundscore = as.numeric(score) + as.numeric(shape)) %>%
  summarise(final = sum(roundscore))
  
#9651 score pt 1

## part 2
#"Anyway, the second column says how the round needs to end: 
#X means you need to lose, Y means you need to end the round in a draw, and 
#Z means you need to win. Good luck!"
# (1 for Rock, 2 for Paper, and 3 for Scissors)

strat %>%
  separate(input,into = c('player1','outcome')) %>%
  mutate(
    # calc partial score for round's outcome
    outcome_score = case_when(
    # player 2 needs to lose  (X) 0 pts
    outcome == 'X' ~ '0', # note that this needs to be char value assigned (otherwise error in case_when)
    # need to draw (Y) 3 pts
    outcome == 'Y' ~ '3',
    # player 2 needs to win (Z) 6 pts
    outcome == 'Z' ~ '6',
    TRUE ~ 'none'
  ),outcome_score = as.numeric(outcome_score),
  # calc score for hand shape player 2 plays in round
  player2shapescore = case_when(
    # outcome is player2 lose (outcome == X)
    player1 == 'A' & outcome == 'X' ~ '3', #scissor 3
    player1 == 'B' & outcome == 'X' ~ '1', # rock 1
    player1 == 'C' & outcome == 'X' ~ '2', # paper 2
    # outcome is draw (outcome == Y)
    player1 == 'A' & outcome == 'Y' ~ '1', # rock 1
    player1 == 'B' & outcome == 'Y' ~ '2', # paper 2 
    player1 == 'C' & outcome == 'Y' ~ '3', # scissor 3
    # outcome is player2 win (outcome == Z)
    player1 == 'A' & outcome == 'Z' ~ '2', # paper 2
    player1 == 'B' & outcome == 'Z' ~ '3', # scissor 3
    player1 == 'C' & outcome == 'Z' ~ '1', # rock 1
    
    TRUE ~ 'none'),
  player2shapescore = as.numeric(player2shapescore)) %>%
  summarise(final = sum(outcome_score + player2shapescore))

# 10560

