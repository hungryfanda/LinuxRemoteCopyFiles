#!/bin/bash

# Start of the Script
echo "---- Check FilePath Eligibility----"
#ExcludedPaths/FilePath Availability/Owner-Group/Permissions Check"

#Excluded Paths
excluded_paths=("/ /bin /usr /opt /root") #Paths where Files are not Eligible to be Copied

if [[ " ${array[*]} " =~ " ${value} " ]]; then
    # whatever you want to do when array contains value
fi

if [[ ! " ${array[*]} " =~ " ${value} " ]]; then
    # whatever you want to do when array doesn't contain value
fi