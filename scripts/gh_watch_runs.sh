gh_watch_runs() {
    local interval=10
    local limit=10
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -i|--interval)
                interval="$2"
                shift 2
                ;;
            -l|--limit)
                limit="$2"
                shift 2
                ;;
            -h|--help)
                echo "Usage: gh_watch_runs [-i|--interval SECONDS] [-l|--limit COUNT]"
                echo "  -i, --interval  Refresh interval in seconds (default: 10)"
                echo "  -l, --limit     Number of runs to show (default: 10)"
                return 0
                ;;
            *)
                echo "Unknown option: $1"
                return 1
                ;;
        esac
    done
    
    # Check dependencies
    for cmd in gh git; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "$cmd command not found. Install required dependencies."
            return 1
        fi
    done
    
    local current_branch
    current_branch=$(git branch --show-current)
    
    echo "Watching GitHub runs for branch: $current_branch (Press Ctrl+C to stop)"
    echo "Refresh interval: ${interval}s | Limit: ${limit} runs"
    echo ""
    
    while true; do
        # Clear screen and move cursor to top
        printf '\033[2J\033[H'
        
        # Show timestamp
        echo "Last updated: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Branch: $current_branch"
        echo ""
        
        # Run gh command with colors preserved
        FORCE_COLOR=1 gh run list --branch "$current_branch" --limit "$limit"
        
        # Wait for interval
        sleep "$interval"
    done
}
