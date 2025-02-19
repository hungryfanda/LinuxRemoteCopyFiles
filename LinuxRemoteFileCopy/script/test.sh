#!/bin/bash

echo "---- LinuxRemoteCopy Script ---"

#Common Variables
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "SCRIPT_DIR - $SCRIPT_DIR"
ansible_dir=$(dirname "$SCRIPT_DIR")"/playbook"
echo "Ansible Directory - $ansible_dir"
pwd=$(pwd)
echo "PWD - $pwd"
timestamp=$(date '+%d%m%y_%H%M%S')

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
declare -a sno_array

#Initialize Source & Destination FileCheck Inventory
echo "[src_check_servers]" > "$src_check_inventory"
echo "[dest_check_servers]" > "$dest_check_inventory"

#Properties File
copy_details="$SCRIPT_DIR/properties/copy_details.txt" #Get Source & Destination details for Copy Files
src_check_inventory="$ansible_dir/inventory/src_check/src_check_${timestamp}"
dest_check_inventory="$ansible_dir/inventory/src_check/dest_check_${timestamp}"
while read line
do
	read -r sno src_server src_filepath dest_server dest_filepath dest_owner dest_group dest_permissions <<< $(echo "$line" | tr ',' ' ')
	if [[ "$src_server" == "$dest_server" ]];then
		echo "$sno.$src_server to $dest_server - Same Server"
	elif [[ "$src_server" != "$dest_server" ]]; then
		echo "$sno.$src_server to $dest_server - Different Server"
	fi
done < "$copy_details"
