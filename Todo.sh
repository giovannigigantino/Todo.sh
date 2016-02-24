#!/bin/bash
# giga  <giovanni.gigantino.843@gmail.com>  2016-02-21
#
# Bash script to have a to-do list directly in your terminal.

#-- VAR
todo=()
todo_file="./.todo"
todo_done_file="./.done"
boolDebug=false  # boolDebug is a bool var used to toggle the debug functions.

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

		if [ -f "$todo_done_file" ]; then
			rm $todo_done_file
		fi
			
		if $boolDebug; then
			echo "'$todo_file' and $todo_done_file files destroyed."
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
	delete=${todo[$1]}
	new_array=()

	touch $todo_done_file
	echo $delete >> $todo_done_file

	for value in "${todo[@]}"; do
	    [[ $value != $delete ]] && new_array+=("$value")
	done

	todo=("${new_array[@]}")
	unset new_array

	if $boolDebug; then
		echo "Element removed."
	fi
}

# Prints, in formatted way, the content of $todo array.
function printList(){
	if [[ $todo != "" ]]; then
		echo "ToDo list:"
	fi
	
	for i in ${!todo[@]}; do
		echo $i: ${todo[$i]}
	done
}

# Checks if $todo_file exists.
function check() {
	if [[ -f $todo_file ]]; then
		echo "Yes: '$todo_file file' found."
	else
		echo "No: '$todo_file' not found."
	fi
}

# Reads the todo list completed elements from the file.
function doneTodo(){
	if [ -f "$todo_done_file" ]; then
		echo "ToDo done list:"

		while read line; do
			echo " X "$line
		done < $todo_done_file

		if $boolDebug; then
			echo "'$todo_done_file' file readed."
		fi
	else
		error "no '$todo_done_file' file found."
	fi
}

# Prints a short guide of the script
function todo_help() {
	echo -e "Todo.sh  <giovanni.gigantino.843@gmail.com
To do list bash script.
Usage:
	todo init              Iniatialize a list to in the current directory
	todo add <'Thing'>     Add 'Thing' to your list
	todo rm <ID>           Remove from the list the selected element
	todo ls                Show a list with the elements of the list and their ID
	todo check             Check if in the current directory a todo list is initializated
	todo destroy           Remove the list from the current directory
	todo help              Show this help"
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
		rm)
		readFile
		removeElement $2
		writeFile
		;;
		check)
		check
		;;
		# Script remove
		destroy)
		destroy
		;;
		# Done todo
		done)
		doneTodo
		;;
		# Help
		help)
		todo_help
		;;
		*)
		error "try to check help option."
		;;
	esac
else
	error "no params given."
fi