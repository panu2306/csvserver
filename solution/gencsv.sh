#!/bin/bash

# to read number of entries we want to have otherwise setting up 10 default entries:
read -p "Enter number of entries you need(default=10):" n
n=${n:-10}

# to get random numbers with index for each random number generated:
for i in `seq 0 $((n-1))`
do
	echo $i, $RANDOM >> inputdata
done


