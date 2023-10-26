#!/bin/bash

# Group info
echo "Names of people in group:" 
echo
echo "- Aditi Shah"
echo
echo "- Parker Duhon"
echo
echo "Name of course: IS 480-Bash Scripting"
echo
echo "Date and time: $(date)"
inputfile="auth.log"
echo
echo "Input file path: $inputfile"
echo
lines=$(wc -l < "$inputfile")
echo "Number of lines: $lines" 
echo
ips=$(grep -o -E "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" "$inputfile" | sort -u)
num_ips=$(echo "$ips" | wc -l)
echo "Number of unique IPs: $num_ips"
echo 
# Print IP info
echo "Unique IP Addresses Accessed:"
printf '%-15s %-15s %s\n' "$ips" | sort -n
