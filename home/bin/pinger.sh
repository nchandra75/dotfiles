#!/bin/bash
while true;
do
	echo  "[" `date` "]"
	ping -c 4 10.65.0.31 | tail -2
	sleep 60
done
