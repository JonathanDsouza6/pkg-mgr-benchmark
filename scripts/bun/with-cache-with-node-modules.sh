#!/bin/bash

source ../../scripts/shared/check-installation.sh
source ../../scripts/shared/clean-cache.sh
source ../../scripts/shared/clean-dependencies.sh
source ../../scripts/shared/clean-lockfile.sh
source ../../scripts/shared/display-results.sh
source ../../scripts/shared/check-bc.sh

# Main script

# Check for bc (used for floating-point arithmetic)
if ! command -v bc &>/dev/null; then
    echo "The 'bc' utility is required but not installed. Please install it first."
    exit 1
fi

echo "===== Bun Installation Benchmark (With Cache & With Node Modules) ====="
echo "This script will run the installation process 1 time and measure performance."
echo "A 5-second pause will be added between each run."

echo "------------------------------------------"
echo "Starting preparation..."
echo "------------------------------------------"

declare -a results
check_bun
clean_cache_bun
bun install

for run in {1..5}; do

    echo "------------------------------------------"
    echo "Run #$run"
    echo "------------------------------------------"

    # Execute the function directly and capture output
    clean_lockfile_bun

    # Run a fresh install and measure time
    echo "Installing dependencies..."

    # Capture start time
    start_time=$(date +%s.%N)

    # Run bun install
    bun install

    # Capture end time
    end_time=$(date +%s.%N)

    # Calculate elapsed time
    elapsed=$(echo "$end_time - $start_time" | bc)

    results[$((run - 1))]=$elapsed
    echo "Start time: $start_time"
    echo "End time: $end_time"
    echo "Elapsed time: $elapsed"
    echo "Run #$run completed in $elapsed seconds"

    # Add a 5-second pause between runs (except after the last one)
    if [ $run -lt 5 ]; then
        echo "Pausing for 5 seconds before next run..."
        sleep 5
    fi

done

echo "------------------------------------------"

# Display the results table
display_results "${results[@]}"

echo "Benchmark completed."
