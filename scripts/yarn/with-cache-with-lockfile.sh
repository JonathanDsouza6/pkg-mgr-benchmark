#!/bin/bash

source ../../scripts/shared/check-installation.sh
source ../../scripts/shared/clean-cache.sh
source ../../scripts/shared/clean-dependencies.sh
source ../../scripts/shared/clean-lockfile.sh
source ../../scripts/shared/display-results.sh
source ../../scripts/shared/check-bc.sh

echo "===== Yarn Installation Benchmark (With Cache & With Lockfile) ====="
echo "This script will run the installation process 1 time and measure performance."
echo "A 5-second pause will be added between each run."

echo "------------------------------------------"
echo "Starting preparation..."
echo "------------------------------------------"

declare -a results
check_yarn
clean_cache_yarn
yarn install

for run in {1..5}; do

    echo "------------------------------------------"
    echo "Run #$run"
    echo "------------------------------------------"

    # clean dependencies and lockfile
    clean_dependencies_yarn

    # Run a fresh install and measure time
    echo "Installing dependencies..."

    # Capture start time
    start_time=$(date +%s.%N)

    # Run yarn install
    yarn install

    # Capture end time
    end_time=$(date +%s.%N)

    # Calculate elapsed time
    elapsed=$(echo "$end_time - $start_time" | bc)

    # # Format the result to 2 decimal places
    # time_taken=$(printf "%.2f" $elapsed)

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
