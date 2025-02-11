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
	echo "$line"
done < "$copy_details"