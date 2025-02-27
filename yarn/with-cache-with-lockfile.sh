#!/bin/bash

# Function to check if yarn is installed
check_yarn() {
    if ! command -v yarn &>/dev/null; then
        echo "yarn is not installed. Please install yarn."
        exit 1
    else
        echo "yarn is already installed."
    fi
}

# Clear yarn cache system wide
clean_cache() {
    echo "Clearing system-wide yarn cache..."
    yarn cache clean

    # Clear yarn cache in current folder
    echo "Clearing local yarn cache..."
    rm -rf .yarn 2>/dev/null
}

# Clear all dependencies
clean_dependencies() {
    echo "Clearing dependencies..."
    find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
}

# Function to delete package-lock.json
clean_lockfile() {
    echo "Deleting package-lock.json..."
    rm -f package-lock.json
}

# Function to display results in a table
display_results() {
    # local -n results_array=$1

    local results_array=("$@") # Store all arguments in an array

    echo "============================================"
    echo "| Run # | Installation Time (seconds) |"
    echo "============================================"

    for ((i = 0; i < ${#results_array[@]}; i++)); do
        printf "| %-5s | %-28s |\n" "$((i + 1))" "${results_array[$i]}"
    done

    echo "============================================"

    # Calculate and display statistics
    total=0
    min=${results_array[0]}
    max=${results_array[0]}

    for time in "${results_array[@]}"; do
        total=$(echo "$total + $time" | bc)

        if (($(echo "$time < $min" | bc -l))); then
            min=$time
        fi

        if (($(echo "$time > $max" | bc -l))); then
            max=$time
        fi
    done

    avg=$(echo "scale=2; $total / ${#results_array[@]}" | bc)

    echo "Average installation time: $avg seconds"
    echo "Minimum installation time: $min seconds"
    echo "Maximum installation time: $max seconds"
}

# Main script

# Check for bc (used for floating-point arithmetic)
if ! command -v bc &>/dev/null; then
    echo "The 'bc' utility is required but not installed. Please install it first."
    exit 1
fi

echo "===== Yarn Installation Benchmark (With Cache & With Lockfile) ====="
echo "This script will run the installation process 1 time and measure performance."
echo "A 5-second pause will be added between each run."

echo "------------------------------------------"
echo "Starting preparation..."
echo "------------------------------------------"

declare -a results
check_yarn
clean_cache
yarn install --no-audit

for run in {1..5}; do

    echo "------------------------------------------"
    echo "Run #$run"
    echo "------------------------------------------"

    # clean dependencies and lockfile
    clean_dependencies

    # Run a fresh install and measure time
    echo "Installing dependencies..."

    # Capture start time
    start_time=$(date +%s.%N)

    # Run yarn install
    yarn install --no-audit

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
