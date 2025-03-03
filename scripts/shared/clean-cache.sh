# Clear yarn cache system wide
clean_cache_bun() {
    echo "Clearing system-wide bun cache..."
    bun pm cache rm

    # Clear Yarn cache using the built-in command
    yarn cache clean --all

    # Remove manually stored cache directories
    rm -rf ~/.yarn/cache
    rm -rf ~/Library/Caches/Yarn

    # Clear npm cache
    npm cache clean --force
    rm -rf ~/.npm 2>/dev/null

    # Clear pnpm cache
    pnpm store prune
}

# Clear npm cache system wide
clean_cache_npm() {
    echo "Clearing system-wide npm cache..."
    npm cache clean --force
    rm -rf ~/.npm 2>/dev/null
}

# Clear pnpm cache system wide
clean_cache_pnpm() {
    echo "Clearing system-wide pnpm cache..."
    pnpm store prune

    # Clear pnpm cache in current folder
    echo "Clearing local pnpm cache..."
    rm -rf .pnpm-store 2>/dev/null
}

# Clear yarn cache system wide
clean_cache_yarn() {
    echo "Clearing system-wide yarn cache..."

    # Clear Yarn cache using the built-in command
    yarn cache clean --all

    # Remove manually stored cache directories
    rm -rf ~/.yarn/cache
    rm -rf ~/Library/Caches/Yarn
}
