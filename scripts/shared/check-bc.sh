check_bc() {
    # Check for bc (used for floating-point arithmetic)
    if ! command -v bc &>/dev/null; then
        echo "The 'bc' utility is required but not installed. Please install it first."
        exit 1
    fi
}
