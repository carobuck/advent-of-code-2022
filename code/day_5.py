## day 5- mixing it up to use python because list wrangling a little easier here for what I have in mind
# need to custom make the input data for crates' original stacking a bit
# arranging container/lists like so: [bottom_box, ... , top_box]

import pandas as pd

# DON'T FORGET 0 BASED INDEXING!!

# set up the input/original container arrangement 

containers = [[] for i in range(9)]
containers[0] = ['Z','J','N','W','P','S']
containers[1] = ['G','S','T']
containers[2] = ['V','Q','R','L','H']
containers[3] = ['V','S','T','D']
containers[4] = ['Q','Z','T','D','B','M','J']
containers[5] = ['M','W','T','J','D','C','Z','L']
containers[6] = ['L','P','M','W','G','T','J']
containers[7] = ['N','G','M','T','B','F','Q','H']
containers[8] = ['R','D','G','C','P','B','Q','W']

instructions = pd.read_csv('/Users/caroline.buck/Desktop/Fun_R/advent-of-code-2022/input/day_5.csv')
instructions

# PART ONE --crate mover moves one crate at a time from stack
# do the rearranging
for i in range(0,502):
    num_box = instructions[i:]['num_boxes'].iloc[0]
    from_pos = instructions[i:]['from'].iloc[0] - 1 # -1 for 0-based indexing
    to_pos = instructions[i:]['to'].iloc[0] - 1

    for j in range(0,num_box):
        temp = containers[from_pos].pop()
        containers[to_pos].append(temp)
    print(i)

containers

# get top box (last elem in each list)
top = []
for i in containers:
    top.append(i.pop())
    print(i)

''.join(top) # MQTPGLLDN

# PART TWO # -- crate mover can move multiple at once (so if has to move 2 in a step, pick up both)
# note: need to reset orig container arrangement above, because pt 1 clobbers it. 
for i in range(0,502):
    num_box = instructions[i:]['num_boxes'].iloc[0]
    from_pos = instructions[i:]['from'].iloc[0] - 1 # -1 for 0-based indexing
    to_pos = instructions[i:]['to'].iloc[0] - 1
    
    temp = containers[from_pos][-num_box:]
    containers[to_pos].extend(temp) # USE EXTEND INSTEAD OF APPEND!! OTHERWISE LOTS OF NESTED LISTS
    del containers[from_pos][-num_box:]
    print(i)
# get top box (last elem in each list)
top = []
for i in containers:
    top.append(i.pop())
    print(i)

''.join(top) # LVZPSTTCZ

## TRASH/TESTER CODE BELOW ##
containers[8][-3:]
tmp = instructions[501:]['num_boxes'].iloc[0]
-instructions[501:]['num_boxes'].iloc[0] 
for i in range(0,tmp):
    print(i)

temp = ['R','D','G','C','P','B','Q','W']
del temp[-3:]
temp[-3:]
temp.pop(-3:)
temp.append(a)