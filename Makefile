# Makefile for countSort examples
#
CC_MC= pgcc -fast -ta=multicore -Minfo=accel
CC_ACC_M= pgcc -fast -ta=tesla:cc75,managed -Minfo=accel

CC=gcc -std=gnu99
CXX=g++
OMP=-fopenmp
INCLUDE=/usr/local/include/trng
LIB=trng4
# DEBUG=-DDEBUG
# DEBUG=

all: omp_nbody_basic

omp_nbody_basic: omp_nbody_basic.c
	${CC} ${OMP} -o omp_nbody_basic omp_nbody_basic.c -lm

######## multicore
mc_nbody_basic: mc_nbody_basic.c
	${CC_MC} -o mc_nbody_basic mc_nbody_basic.c

######## acc_loops (kernels)
k_nbody_basic: k_nbody_basic.c
	${CC_ACC_M} -o k_nbody_basic k_nbody_basic.c	

clean:
	rm -f omp_nbody_basic mc_nbody_basic