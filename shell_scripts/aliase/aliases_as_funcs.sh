#!/bin/bash

source ${scripts}/farbcodes.sh
source ${scripts}/git_status
source ${scripts}/new_cd
source ${scripts}/parent_folder

function installer() {
	echo -e "${1}\n${2}" | ${scripts}/Installer
}

function update() {
	${scripts}/updater
}

function bsed() {
	echo $3 | ${scripts}/bsed $1 $2
}

function duh() {
	folder=${1:-.}
	du -hx -d 1 "$folder" | sort -h
}

function contains() {
	[[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]] && echo 1 || echo 0
}
