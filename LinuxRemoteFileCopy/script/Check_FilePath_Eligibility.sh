#!/bin/bash

# Start of the Script
echo "---- Check FilePath Eligibility----"
#ExcludedPaths/FilePath Availability/Owner-Group/Permissions Check"

#Inputs - Command Line Arguments
filepath="$1"

#Excluded Paths
excluded_paths=("/" "/bin" "/usr" "/opt" "/root") #Paths where Files are not Eligible to be Copied

#Flag Variables
excludedpath_flag="1"
filepath_availability_flag="0"
owner_flag="0"
group_flag="0"

#Check For Excluded Paths
if [[ " ${excluded_paths[*]} " =~ " ${filepath} " ]]; then
    # whatever you want to do when array contains value
    echo "ExcludedPath"
elif [[ ! " ${excluded_paths[*]} " =~ " ${filepath} " ]]; then
    # whatever you want to do when array doesn't contain value
    echo "Not ExcludedPath"
    excludedpath_flag="0"
fi

if [[ "$excludedpath_flag" == "0" ]]; then
    #Check if File Exists
    filepath_check=$(ls -d "$filepath" 2>&1)
    filepath_check=$(echo "$filepath_check" | awk '{$1=$1;print}')

    if [[ "$filepath_check" == *"No such file or directory"* ]]; then
        echo "Filepath $filepath does not Exist!"
    else
        echo "Filepath $filepath Available!"
        filepath_availability_flag="1"
    fi
fi

#Following Checks only apply to Destination Server
if [[ "$server_type" == "DEST" ]]; then
    if [[ "$filepath_availability_flag" == "1" ]]; then
        #Check if owner Exists on the Server
        owner_check=$(id -un "$owner" 2>&1)
        owner_check=$(echo "$owner_check" | awk '{$1=$1;print}')
        if [[ "$owner_check" == "$owner" ]]; then
           echo "$owner Account Exists!"
           owner_flag="1"
        else
            echo "$owner Account does not Exist!"
        fi
    fi

    if [[ "$owner_flag" == "1" ]]; then
        #Check if $owner has $group as Primary Group
        group_check=$(id -gn "$owner" | grep -o "$group" 2>&1)
        group_check=$(echo "$group_check" | awk '{$1=$1;print}')
        if [[ "$group_check" == "$group" ]]; then
            echo "$group Primary Group Available"
            group_flag="1"
        else
            echo "$group Primary Group NOT Available"
            #Check if $owner has $group as Secondary Group
            group_check=$(id -Gn "$owner" | grep -o "$group" 2>&1)
            group_check=$(echo "$group_check" | awk '{$1=$1;print}')
            if [[ "$group_check" == "$group" ]]; then
                echo "$group Secondary Group Available"
                group_flag="1"
            else
                echo "$group Secondary Group NOT Available"
            fi
        fi
    fi
fi
