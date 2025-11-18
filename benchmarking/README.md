# Benchmarking Transcriptformer

To compare performance across a variety of GPUs, this fork has been modified to track the padded token throughput during inference.

## Quickstart

```
# Pull the human model
make downloads
# Run the benchmark sweep
make benchmark
```

## Building everything yourself

```
# Build the container with the current code
make build
# Pull the human model
make downloads
# Run the benchmark sweep
make benchmark
# Clean up
make clean
```

Modify `HUB_USER` in the `Makefile` if you would like to push to a different registry.
