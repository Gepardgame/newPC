#!/bin/bash

linesOfFile=$(wc -l < install_from_list)
i=1
while [ $i -lt $linesOfFile ]
do
	programm=$(cat -n install_from_list | grep ${i} | cut --bytes=8-)
	sudo apt install $programm
       	#echo $programm	
	let i=$i+1	
done
