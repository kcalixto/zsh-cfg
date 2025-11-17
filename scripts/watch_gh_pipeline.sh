watch_gh_pipeline() {
    # Verify git repo
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Not a git repository"
        return 1
    fi
    
    # Get repo name
    local repo_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    repo_name=$(basename "$(git rev-parse --show-toplevel)")
    
    # Run in background
    {
        # Get latest workflow run
        local run_id=$(gh run list --limit 1 --json databaseId --jq '.[0].databaseId' 2>/dev/null)
        
        if [[ -z "$run_id" ]]; then
            notify "$repo_name" "Deployment already done"
            return
        fi
        
        # Check if already completed
        local status=$(gh run view "$run_id" --json status --jq '.status' 2>/dev/null)
        
        if [[ "$status" == "completed" ]]; then
            local conclusion=$(gh run view "$run_id" --json conclusion --jq '.conclusion' 2>/dev/null)
            if [[ "$conclusion" == "success" ]]; then
                notify "$repo_name" "Deployment done"
            else
                notify "$repo_name" "Deployment failed"
            fi
            return
        fi
        
        # Poll for completion
        while true; do
            status=$(gh run view "$run_id" --json status --jq '.status' 2>/dev/null)
            
            if [[ "$status" == "completed" ]]; then
                local conclusion=$(gh run view "$run_id" --json conclusion --jq '.conclusion' 2>/dev/null)
                if [[ "$conclusion" == "success" ]]; then
                    notify "$repo_name" "Deployment done"
                else
                    notify "$repo_name" "Deployment failed"
                fi
                break
            fi
            
            sleep 60
        done
    } &
    
    echo "Monitoring pipeline in background (PID: $!)"
}
