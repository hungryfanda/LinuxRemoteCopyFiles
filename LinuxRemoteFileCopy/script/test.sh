#!/bin/bash

echo "---- LinuxRemoteCopy Script ---"

#Common Variables
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "SCRIPT_DIR - $SCRIPT_DIR"
pwd=$(pwd)
echo "PWD - $pwd"

#Server Details Arrays
declare -a src_server_array
declare -a dest_server_array
declare -a src_filepath_array
declare -a dest_filepath_array
declare -a src_owner_array
declare -a src_group_array
declare -a dest_owner_array
declare -a dest_group_array
declare -a src_owner_array
declare -a src_group_array
declare -a src_permission_array
declare -a dest_permission_array

#Properties File
copy_details="$SCRIPT_DIR/properties/copy_details.txt" #Get Source & Destination details for Copy Files
while read line
do
	line_arr=($(echo "$line" | tr ',' ' '))
	read -r src_server src_filepath dest_server dest_filepath dest_owner dest_group dest_permissions <<< $(echo "$line" | tr ',' ' ')
	if [ "$src_server" -eq "$dest_server" ];then
		echo "Same Server File Copy"
	elif [[ "$src_server" -ne "$dest_server" ]]; then
		echo "Different Server File Copy"
	fi
done < "$copy_details"