#!/bin/bash

update
for i in $( cat install_from_list_pre); do
	sudo apt -y install $i
done


for i in $( ls install_by_scripts ); do
	cd Downloads
	./install_by_scripts/$i
done

for i in $( cat install_from_list); do
	sudo apt -y install $i
done
update 
