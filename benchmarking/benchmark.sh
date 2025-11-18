#!/bin/bash

mkdir benchmark_logs

GPU_NAME=$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader | tr ' ' '_')

INPUT=/workspace/transcriptformer/test/data/human_val.h5ad
CACHE=~/cache

for bs in 8 16 32 64 128; do
	for rep in 1 2 3; do
		run_name=${GPU_NAME}_bs${bs}_rep${rep}
		nvidia-smi -i ${CUDA_VISIBLE_DEVICES:-0} --query-gpu=timestamp,name,utilization.gpu,memory.used --format=csv -l 1 > benchmark_logs/${run_name}.log.gpu &
		N=$!
		transcriptformer inference --checkpoint-path ${CACHE}/tf_sapiens/ --data-file ${INPUT} --output-path /tmp/ --batch-size ${bs} 2>&1 | tee benchmark_logs/${run_name}.log
		kill $N
	done
done

