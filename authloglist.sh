#!/bin/bash

# Set the input and output file names
INPUT_FILE="$1"
OUTPUT_FILE="$INPUT_FILE.expanded"

# Initialize the output file
> "$OUTPUT_FILE"

# Process the input file and extract repeated lines
while read line; do
  # Split the line into the message and the number of repeats
  message=$(echo "$line" | cut -d '"' -f 2)
  repeats=$(echo "$line" | cut -d '"' -f 4)

  # If the line is a log aggregation message, skip it
  if [[ "$message" == "message repeated" ]]; then
    continue
  fi

  # Append the message to the output file the number of times it was repeated
  for i in $(seq 1 "$repeats"); do
    echo "$message" >> "$OUTPUT_FILE"
  done
done < "$INPUT_FILE"

# Copy all non-repeated lines to the output file
grep -v "message repeated" "$INPUT_FILE" >> "$OUTPUT_FILE"
