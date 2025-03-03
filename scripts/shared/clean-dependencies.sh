# Clear all dependencies
clean_dependencies_bun() {
    echo "Clearing dependencies..."
    find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
}

# Clear all dependencies
clean_dependencies_npm() {
    echo "Clearing dependencies..."
    find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
}

# Clear all dependencies
clean_dependencies_pnpm() {
    echo "Clearing dependencies..."
    find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
}

# Clear all dependencies
clean_dependencies_yarn() {
    echo "Clearing dependencies..."
    find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
}
