#!/bin/bash


File=$1

grep cron $File  | grep -v 'closed' | cut -d ' ' -f 1-3 


