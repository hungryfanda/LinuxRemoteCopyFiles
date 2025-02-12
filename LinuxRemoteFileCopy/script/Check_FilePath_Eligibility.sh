#!/bin/bash

# Start of the Script
echo "---- Check FilePath Eligibility----"
#ExcludedPaths/FilePath Availability/Owner-Group/Permissions Check"

#Inputs - Command Line Arguments
filepath="$1"

#Excluded Paths
excluded_paths=("/" "/bin" "/usr" "/opt" "/root") #Paths where Files are not Eligible to be Copied

if [[ " ${excluded_paths[*]} " =~ " ${filepath} " ]]; then
    # whatever you want to do when array contains value
    echo "ExcludedPath"
fi

if [[ ! " ${excluded_paths[*]} " =~ " ${filepath} " ]]; then
    # whatever you want to do when array doesn't contain value
    echo "Not ExcludedPath"
fi