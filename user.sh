#!/bin/bash

if [ $# -eq 0 ] ;
then 
	echo "please provide input file like this  ./script_name inputfile.txt"
        exit 1
fi

inputfile="$1"

if [ -f $inputfile ];
then 
	echo "Starting processing the file"
else
	echo "this file $inputfile is missing"
fi


while read -r line; do
    name=$(cut -d',' -f1 <<< "$line" | xargs)
    email=$(cut -d',' -f2 <<< "$line" | xargs)
    id=$(cut -d',' -f3 <<< "$line" | xargs)

    if [[ -z "$email" || "$email" != *@* || "$email" == *@localhost* || "$email" != *.* ]]; then
        echo "Warning: Invalid email for $name" 
        continue
    fi

    if [[ -z "$id" || ! "$id" =~ ^[0-9]+$ ]]; then
        echo "Warning: Invalid ID for $name" 
        continue
    fi

    if (( id % 2 == 0 )); then
        parity="even"
    else 
        parity="odd"
    fi
    echo "The $id of $email is $parity number."
done < <(tail -n +2 "$inputfile")

echo "processing complete"
