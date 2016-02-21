#!/bin/bash
# giga  <giovanni.gigantino.843@gmail.com>  2016-02-21
#
# Bash script to have a to-do list directly in your terminal.

#-- VAR
todo=()
todo_file="./.todo"
# boolDebug is a bool var used to toggle the debug functions.
boolDebug=false

#-- FUNC
# Creates $todo_file
function initFile(){
	touch $todo_file
	
	if $boolDebug; then
		echo "'$todo_file' file created."
	fi
}

# Removes $todo_file
function destroy(){
	if [ -f "$todo_file" ]; then
		rm $todo_file

		if $boolDebug; then
			echo "'$todo_file' file destroyed."
		fi
	else
		error "no '$todo_file' file found."
	fi
}

# Reads the todo list from the file, the points are saved in
# $todo array.
function readFile(){
	if [ -f "$todo_file" ]; then
		while read line; do
			todo+=("$line")
		done < $todo_file

		if $boolDebug; then
			echo "'$todo_file' file readed."
		fi
	else
		error "no '$todo_file' file found."
	fi
}

# Writes the $todo content in the txt file.
function writeFile(){
	if [ -f "$todo_file" ]; then
		truncate -s 0 $todo_file

		for i in ${!todo[@]}; do
			echo "${todo[$i]}" >> $todo_file
		done

		if $boolDebug; then
			echo "'$todo_file' file writed."
		fi
	else
		error "no '$todo_file' file found."
	fi
}

# Adds an element to $todo array.
#
# $1  Element
function insertElement(){
	todo+=("$1")

	if $boolDebug; then
		echo "Element added."
	fi
}

# Removes an element from $todo array.
#
# $1  Element position
function removeElement(){
	todo=("${todo[@]:0:$1} ${todo[@]:$(($1+1))}")

	if $boolDebug; then
		echo "Element removed."
	fi
}

# Prints, in formatted way, the content of $todo array.
function printList(){
	for i in ${!todo[@]}; do
		echo $i: ${todo[$i]}
	done
}

# Prints an error message.
#
# $1  Body of the message
function error(){
	echo "Error: $1"
}

#-- MAIN
if [[ $# > 0 ]]; then
	case $1 in
		# Script initialization
		init)
		initFile
		;;
		# Element add
		add)
		readFile
		insertElement "$2"
		writeFile
		;;
		# Elements list
		ls)
		readFile
		printList
		;;
		# Element remove
		rem)
		readFile
		removeElement $2
		writeFile
		;;
		# Script remove
		destroy)
		destroy
		;;
		*)
		error "try to check help option."
		;;
	esac
else
	error "no params founded."
fi