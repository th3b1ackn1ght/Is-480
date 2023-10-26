#!/bin/bash

inputfile=$1
outputfile=${inputfile}.expanded

while read line; do

  if [[ $line == *"repeated"* ]]; then
    
    # Get repeat count
    count=$(echo $line | cut -d' ' -f1)
    
    # Get message 
    message=$(echo $line | cut -d'"' -f2)

    for ((i=0; i<$count; i++)); do
      echo "$message" >> $outputfile
    done

  else
    echo "$line" >> $outputfile
  fi

done < $inputfile

# Remove aggregated lines
sed -i '/repeated/d' $inputfile

# Append remaining lines 
cat $inputfile >> $outputfile

echo "Expanded output written to $outputfile"