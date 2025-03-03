# Function to check if bun is installed
check_bun() {
    if ! command -v bun &>/dev/null; then
        echo "bun is not installed. Please install bun."
        exit 1
    else
        echo "bun is already installed."
    fi
}

# Function to check if npm is installed
check_npm() {
    if ! command -v npm &>/dev/null; then
        echo "npm is not installed. Please install Node.js which includes npm."
        exit 1
    else
        echo "npm is already installed."
    fi
}

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

# Function to check if yarn is installed
check_yarn() {
    if ! command -v yarn &>/dev/null; then
        echo "yarn is not installed. Please install yarn."
        exit 1
    else
        echo "yarn is already installed."
    fi
}
