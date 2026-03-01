#!/bin/bash
for ((num=1; num<=3; num++))
do
    mkdir "demo$num"
done
#while loop
num=0;
while[[ $num -le 5 ]]
do
	echo "$num"
	num=$((num+1))

done
