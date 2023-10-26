#!/bin/bash

############################################################################
# Author: Parker Duhon
# Date: Sept 7 2023
# Summary: This script takes multiple auth.log file as input and prints out
# the date,time, and user for each cron job that opens
############################################################################



#tells which file it is open
echo File

# Multiple arugments 
File=$@

# for loop to check auth log files
for file in  ./auth.logfiles/*; do

#other part of for loop to check cron jobs in authlog files
grep cron $File  | grep -v 'closed' | cut -d ' ' -f 1-3,11 

done
