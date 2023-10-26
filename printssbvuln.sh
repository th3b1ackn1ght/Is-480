 #!/bin/bash

##############################
# Parker Duhon 
# 09-12-23
# with the help of claude.ai
#############################


# Check if argument provided
if [ -z "$1" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

# Store filename 
filename=$1

# Search file for pattern
matched_lines=$(grep -c " Speculative Store Bypass vulnerability  " $filename)


# Check if matches found
if [ "$matched_lines" -gt 0 ]; then
  echo "This system is vulnerable to Speculative Store Bypass"
elif [ "$matched_lines" -le 0 ]; then
  echo " This system is not vulnerable to Speculative Store Bypass"

else
  echo "Could not determine if this system is vulnerable to Speculative Store Bypass" 
fi
