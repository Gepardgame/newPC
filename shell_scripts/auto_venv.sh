#!/bin/bash
venvs=(".venv" "venv" "env")
function venv() {

	if [[ -z "$VIRTUAL_ENV" ]]; then
		## If env folder is found then activate the vitualenv
		for i in $(get_parent_folder "$PWD" 3); do
			for venv_dir in ${venvs[@]}; do
				if [[ -d "$i/$venv_dir" ]]; then
					source "$i/$venv_dir/bin/activate"
					break
				fi
			done
		done
	else
		## check the current folder belong to earlier VIRTUAL_ENV folder
		# if yes then do nothing
		# else deactivate
		parentdir="$(dirname "$VIRTUAL_ENV")"
		if [[ "$PWD"/ != "$parentdir"/* ]]; then
			deactivate
		fi
	fi

}
