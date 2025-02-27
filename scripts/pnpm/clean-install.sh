#!/bin/bash

# Function to check if pnpm is installed
check_pnpm() {
    if ! command -v pnpm &>/dev/null; then
        echo "pnpm is not installed. Installing..."
        npm install -g pnpm
        echo "pnpm installed successfully."
    else
        echo "pnpm is already installed."
    fi
}

# Clear pnpm cache system wide
clean_cache() {
    echo "Clearing system-wide pnpm cache..."
    pnpm store prune

    # Clear pnpm cache in current folder
    echo "Clearing local pnpm cache..."
    rm -rf .pnpm-store 2>/dev/null
}

# Function to delete pnpm-lock.yaml
clean_lockfile() {
    echo "Deleting pnpm-lock.yaml..."
    rm -f pnpm-lock.yaml
}

# Clear all dependencies
clean_dependencies() {
    echo "Clearing dependencies..."
    find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
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

echo "===== PNPM Installation Benchmark (With Node Modules) ====="
echo "This script will run the installation process 1 time and measure performance."
echo "A 5-second pause will be added between each run."

echo "------------------------------------------"
echo "Starting preparation..."
echo "------------------------------------------"

declare -a results
check_pnpm

for run in {1..5}; do

    echo "------------------------------------------"
    echo "Run #$run"
    echo "------------------------------------------"

    # Clear cache, lockfile and dependencies
    clean_cache
    clean_dependencies
    clean_lockfile

    # Run a fresh install and measure time
    echo "Installing dependencies..."

    # Capture start time
    start_time=$(date +%s.%N)

    # Run pnpm install
    pnpm install

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
