#!/bin/bash


function get_parent_folder {
	directory="$1"
	count=$(echo "${directory//\//\ }"|wc -w)
	while [ "$directory" != "/" ] && [ "$count" -ge "$2" 2> /dev/null ]; do
		echo "$directory"
    		directory=$(dirname "$directory")
		count=$(echo "${directory//\//\ }"|wc -w)
	done
}
