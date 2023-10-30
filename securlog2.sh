#!/bin/bash

# Prompt for info
read -p "Enter path to key pair pem file: " key_pair_path
read -p "Enter instance user name: " instance_user
read -p "Enter instance public DNS name: " instance_dns 

# Connect to instance
ssh -i $key_pair_path $instance_user@$instance_dns

# Copy auth log 
scp $instance_user@$instance_dns:/var/log/auth.log ./auth.log

# Parse auth log for security events 

# Invalid usernames
grep "Failed password for invalid user" ./auth.log | awk '{print $NF}' | sort | uniq -c | sort -nr

# Root login attempts
grep "Failed password for root" ./auth.log | awk '{print $11}' | sort | uniq -c | sort -nr

# Ubuntu login attempts
grep "Failed password for ubuntu" ./auth.log | awk '{print $11}' | sort | uniq -c | sort -nr 

# Disconnect 
exit

# Print ASCII art peace sign
cat <<EOF 

888     888 d8b 888                   
888     888 Y8P 888                   
888     888     888                   
Y88b   d88P 888 888 888  888 88888b.   
Y88b d88P  888 888 888  888 888 "88b  
Y88o88P"   888 888 888  888 888  888  
Y888P      888 888 888  888 888 d88P   
                                 888       
                                 888       
                             Y8b d88P     
                              "Y88P"      

EOF

# Print creation text 
cat <<EOF
====================================================================== 
Created by: Parker Duhon, Published on: $(date), and TLDR: Peace out!
======================================================================
EOF