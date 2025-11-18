#!/bin/bash  
for f in *gpu; do
	echo -e "$f\t$(tail -n +2 $f | sed -e 's/, /,/g' | cut -f 4 -d ',' | cut -f 1 -d ' ' | sort -r -n -k 1 | head -n 1)"; 
done
