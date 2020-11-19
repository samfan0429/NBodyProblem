# Makefile for countSort examples
#
CC_MC= pgcc -fast -ta=multicore -Minfo=accel
CC_ACC_M= pgcc -fast -ta=tesla:cc75,managed -Minfo=accel
CC_ACC= pgcc -fast -ta=tesla:cc75 -Minfo=accel

CC=gcc -std=gnu99
CXX=g++
OMP=-fopenmp
INCLUDE=/usr/local/include/trng
LIB=trng4
DEBUG=-DDEBUG
# DEBUG=

all: omp_nbody_basic nbody_basic kernels_nbody_basic

######## Sequential
nbody_basic: nbody_basic.c
	${CC} -o nbody_basic nbody_basic.c -lm

######## OMP
omp_nbody_basic: omp_nbody_basic.c
	${CC} ${OMP} -o omp_nbody_basic omp_nbody_basic.c -lm

######## trng omp
omp_nbody_trng: omp_nbody_trng.cpp
	$(CXX) ${OMP} -o omp_nbody_trng omp_nbody_trng.cpp -I$(INCLUDE) -l$(LIB)	

######## multicore
mc_nbody_basic: mc_nbody_basic.c
	${CC_MC} -o mc_nbody_basic mc_nbody_basic.c

######## acc_data (kernels managed)
kernels_nbody_basic: kernels_nbody_basic.c
	${CC_ACC_M} -o kernels_nbody_basic kernels_nbody_basic.c

######## acc_loops
loops_nbody_basic: loops_nbody_basic.c
	${CC_ACC} -o loops_nbody_basic loops_nbody_basic.c


clean:
	rm -f omp_nbody_basic mc_nbody_basic kernels_nbody_basic