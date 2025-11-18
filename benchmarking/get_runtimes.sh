#!/bin/bash

for GPU in $(ls benchmark_logs/*log | sed -e "s/benchmark_logs\///" -e "s/_bs.*//" | sort -u); do
	for bs in 8 16 32 64 128; do
		#rep_array=()
		echo -ne "\n${GPU},${bs}"
		for rep in 1 2 3; do
			val=$(grep -Po '(?<=tokens/sec:\s).*$' benchmark_logs/${GPU}_bs${bs}_rep${rep}.log)
			echo -ne ",${val}"
			#rep_array+=(grep -HPo '(?<=tokens/sec:\s).*$' benchmark_logs/${GPU}_bs${bs}_rep${rep}.log)
		done
	done
done
echo



#grep -HEo 'tokens/sec:.*$' benchmark_logs/*log
