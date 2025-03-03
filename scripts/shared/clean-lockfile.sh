# Function to delete bun.lock
clean_lockfile_bun() {
    echo "Deleting bun.lock ..."
    rm -f bun.lock
}

# Function to delete package-lock.json
clean_lockfile_npm() {
    echo "Deleting package-lock.json..."
    rm -f package-lock.json
}

# Function to delete pnpm-lock.yaml
clean_lockfile_pnpm() {
    echo "Deleting pnpm-lock.yaml..."
    rm -f pnpm-lock.yaml
}

# Function to delete package-lock.json
clean_lockfile_yarn() {
    echo "Deleting package-lock.json..."
    rm -f package-lock.json
}
