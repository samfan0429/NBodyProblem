#!/bin/bash

# Runs a series of tests that can fairly easily be copied into the spreadsheet.

# Author: Sun Gyu Park

# Usage:
#           
#    will run each problem size set below 10 times using a variety of thread counts
#    and write to stdout (the screen)
#  ***Fix the value after .sh to change the number of trials.
#    A test to display on screen
#           bash ./mc_nbody_strong_tests.sh 5
#    For a full test and recording, try:
#          bash ./mc_nbody_strong_tests.sh 10 > tests_mc.tsv
num_times=$1

# print a header for the trial, #threads, and set of probelm sizes
printf "trial \t256 \t512 \t1024 \t2048 \t4096 \t8192 \t16384 \t32768 \t65536 \t131072\n"

counter=1
# printf "$counter\t$num_threads\t"
while [ $counter -le $num_times ]
do
     # $counter is the trial number
    printf "$counter\t"
      
    for problem_size in 256 512 1024 2048 4096 8192 16384 32768 65536 131072
    do
        command="./mc_nbody_basic 0 $problem_size 16 0.01 100 g"
            

        $command
      done
    printf "\n"
      
    ((counter++))    
done

