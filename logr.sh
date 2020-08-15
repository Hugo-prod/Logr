#!/bin/bash

# LOG_On_FILE: Write log in logfile.log if true
readonly LOG_ON_FILE=true;

# NAME_OF_THIS_FILE: Get the name of the file where logr is executed
readonly NAME_OF_THIS_FILE=$(basename -s .sh "$0");

echo_timing() {
	#--------------------------------------------------------
	# Out: [19/01/2020 18h19:56] Hello
	#--------------------------------------------------------
	echo [`date +%d"/"%m"/"%Y" "%H"h"%M":"%S`] $@
}

echo_color(){
	COLOR=$1; MSG=$2;

	if [[ ${COLOR} == *"WHITE"* ]]; then echo -e "\\e[39m"${MSG}"\\e[0m";
	elif [[ ${COLOR} == *"RED"* ]]; then echo -e "\\e[31m"${MSG}"\\e[0m";
	elif [[ ${COLOR} == *"GREEN"* ]]; then echo -e  "\\e[32m"${MSG}"\\e[0m"; 
	elif [[ ${COLOR} == *"YELLOW"* ]]; then echo -e  "\\e[33m"${MSG}"\\e[0m"; 
	elif [[ ${COLOR} == *"BLUE"* ]]; then echo -e  "\\e[34m"${MSG}"\\e[0m"; 
	fi;
}

echo_console(){
	TYPE_OF_MSG=$1; MSG=$2;

	if [[ ${TYPE_OF_MSG} == *"1"* ]] || [[ ${TYPE_OF_MSG} == *"SUCCESS"* ]]; then echo_timing "$(echo_color "GREEN" "[+]: ${MSG}")";
	elif [[ ${TYPE_OF_MSG} == *"2"* ]] || [[ ${TYPE_OF_MSG} == *"FAIL"* ]]; then echo_timing "$(echo_color "RED" "[-]: ${MSG}")";
	elif [[ ${TYPE_OF_MSG} == *"3"* ]] || [[ ${TYPE_OF_MSG} == *"WARNING"* ]]; then echo_timing "$(echo_color "YELLOW" "[!]: ${MSG}")";
	elif [[ ${TYPE_OF_MSG} == *"4"* ]] || [[ ${TYPE_OF_MSG} == *"INFO"* ]]; then echo_timing "$(echo_color "BLUE" "[i]: ${MSG}")";
	elif [[ ${TYPE_OF_MSG} == *"0"* ]] || [[ ${TYPE_OF_MSG} == *"DEFAULT"* ]]; then echo_timing "$(echo_color "WHITE" "[:]: ${MSG}")";
	else MSG=${TYPE_OF_MSG}; echo_timing "$(echo_color "WHITE" "[:]: ${MSG}")";
	fi;
}

logr(){
	TYPE_OF_MSG=$1; MSG=$2;

	if [[ ${LOG_ON_FILE} ]]; then echo_console "${TYPE_OF_MSG}" "${MSG}" | tee -a "${NAME_OF_THIS_FILE}.logs";
	else echo_console "${TYPE_OF_MSG}" "${MSG}"; fi;
}


demo_logr(){
	# Sample demo: 

	logr "DEFAULT" "This is default";
	logr "Simple shortcut echo with datetime";
	logr "SUCCESS" "This a success";
	logr "FAIL" "This is a hell";
	logr "INFO" "This is a info";
	logr "WARNING" "This is a warning";

	logr "0" "This is default";
	logr "Simple shortcut echo with datetime";
	logr "1" "This a success";
	logr "2" "This is a hell";
	logr "3" "This is a warning";
	logr "4" "This is a info";
}

demo_logr;
