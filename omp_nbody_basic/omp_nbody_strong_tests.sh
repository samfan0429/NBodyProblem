#!/bin/bash

# Runs a series of tests that can fairly easily be copied into the spreadsheet.

# Author: Sun Gyu Park

# Usage:
#           
#    will run each problem size set below 10 times using a variety of thread counts
#    and write to stdout (the screen)
#  ***Fix the value after .sh to change the number of trials.
#    A test to display on screen
#           bash ./omp_nbody_strong_tests.sh 5
#    For a full test and recording, try:
#          bash ./omp_nbody_strong_tests.sh 10 > omp_nbody_strong.tsv
num_times=$1

# print a header for the trial, #threads, and set of probelm sizes
# printf "trial \t#th \t256 \t512 \t1024 \t2048 \t4096 \t8192 \t16384 \t32768\n"
printf "trial \t#th \t32768 \t65536 \t131072\n"

# each trial will run num_times using a cretain number of threads
for num_threads in 1 2 4 8 12 16
do

  # run the series of problem sizes with the current value of num_threads
  counter=1
  # printf "$counter\t$num_threads\t"
  while [ $counter -le $num_times ]
  do
     # $counter is the trial number
      printf "$counter\t$num_threads\t"
      if [  "$num_threads" -le "6"  ]; then
        for problem_size in 256	512	1024	2048	4096	8192	16384
        do
          command="./omp_nbody_basic $num_threads $problem_size 16 0.01 100 g"

          $command
        done
        printf "\n"
     # run each problem size once
     else
        printf "\t"
        for problem_size in 256	512	1024	2048	4096	8192	16384 32768 65536 131072
        do
          
          command="./omp_nbody_basic $num_threads $problem_size 16 0.01 100 g"
            

          $command
          
        done
        printf "\n"
      fi
      
      ((counter++))    
  done
  printf "\n"

done
