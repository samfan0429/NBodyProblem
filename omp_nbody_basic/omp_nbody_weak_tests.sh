#!/bin/bash

# Runs a series of tests that can fairly easily be copied into the spreadsheet.

# Author: Libby Shoop

# Example Usage:
#          bash ./run_weak_tests.sh  1048576 3 2
#
#    will run 2 replicas for 3 separate weak scaling tests,
#    each one starting from  problem sizes
#    1048576, 1048576*2, and 1048576*4 respectively
#    and write to stdout (the screen)
#
#    For a full test, try 10 replicas:
#          bash ./run_weak_tests.sh  1048576 3 10 > weak_tests.tsv
num_times=$3
initial_size=$1
weak_scale_lines=$2

# print a header for the trial, #threads, and set of probelm sizes
printf "trial \tsize \tthreads \tStringCount+Ouput\n"
problem_size=$initial_size
double=0

for line in $(seq 1 $weak_scale_lines)
do
  echo "line: " $line

  # each trial will run num_times using a cretain number of threads
  for num_threads in 1 2 4 8 16
  do
    #echo "problem: " $problem_size    #debug
    #echo "threads: " $num_threads     #debug

    # run the series of tests with the current value of num_threads
    # and current problem size
    counter=1
    while [ $counter -le $num_times ]
    do
       # $counter is the trial number
        printf "$counter\t$problem_size\t$num_threads\t"

     # run the problem size
      # for problem_size in 1048576 2097152 4194304 8388608 16777216 33554432
      # do
        command="./countSort_omp -t $num_threads -n $problem_size "
        

        $command
        # printf "$command  "    #debug

        printf "\n"
        ((counter++))
    done     # number of trials
    problem_size=$(( $problem_size*2 ))
  done       # sets of threads
  printf "\n"

  # set the next starting problem size for the next weak sclability line
  double=$(( 2**$line ))
  problem_size=$(( $initial_size*$double ))

done    # number of weak scale lines
