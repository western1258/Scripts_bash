#!/bin/bash
# Copiar los archivos de un directorio con cierta extension a otro directorio

d1="$1"
d2="$2"
ext="$3"

if [ $# -lt 3 ]; then 
	exit 1
fi

if [ -d "$d1" ] && [ -d "$d2" ]; then
	for i in "$d1"/*; do
		if [ -f "$i" ] && [[ "$i" == *."$ext" ]]; then 
			cp "$i" "$d2"
		fi
	done
	exit 0
else
	exit 1
fi


