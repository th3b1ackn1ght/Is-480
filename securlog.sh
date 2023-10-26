#!/bin/bash

logfile=$1

# 1. Invalid usernames
echo "Invalid usernames (sorted):"
grep "Invalid user" $logfile | cut -d' ' -f3 | sort | uniq -c | sort -n

# 2. Root logins 
echo -e "\nRoot logins (sorted):"
grep "root" $logfile | cut -d' ' -f3 | sort | uniq -c | sort -n

# 3. Ubuntu logins
echo -e "\nUbuntu logins (sorted):"  
grep "ubuntu" $logfile | cut -d' ' -f3 | sort | uniq -c | sort -n

# 4. Invalid usernames
echo -e "\nInvalid usernames (sorted):"
invalid_users=$(grep "Invalid user" $logfile | cut -d' ' -f6 | sort -u)

# Count total invalid usernames
total_invalid=$(echo "$invalid_users" | wc -l)
echo "Total unique invalid usernames: $total_invalid"

# List each with count
for user in $invalid_users; do
  count=$(grep "Invalid user.*$user" $logfile | wc -l)
  echo "$user : $count"
done | sort -n