# Fetch run status for the selected job
gh_run_status() {
    # Check dependencies
    for cmd in gh jq git fzf; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "$cmd command not found. Install required dependencies."
            return 1
        fi
    done

    # Get current branch
    local current_branch
    current_branch=$(git branch --show-current)
    
    # Fetch runs data
    local runs_data
    runs_data=$(gh run list --branch "$current_branch" --limit 10 --json 'databaseId,createdAt,event,status,conclusion,name,workflowName')

    # if len = 0 should print "No runs found for branch"
    if [[ -z "$runs_data" || "$runs_data" == "[]" ]]; then
        echo "No runs found for branch $current_branch"
        return 1
    fi
    
    # Select run with fzf
    local selected_run
    selected_run=$(echo "$runs_data" | jq -r '.[] | "\(.databaseId) \(.status) \(.workflowName) \(.createdAt[:19])"' | \
        fzf --preview "echo '$runs_data' | jq -r '.[] | select(.databaseId == {1}) | \"ID: \" + (.databaseId | tostring) + \"\nWorkflow: \" + .workflowName + \"\nName: \" + .name + \"\nEvent: \" + .event + \"\nStatus: \" + .status + \"\nConclusion: \" + (.conclusion // \"null\") + \"\nCreated: \" + .createdAt'" \
        --preview-window=right:50%)
    
    if [[ -z "$selected_run" ]]; then
        echo "No run selected"
        return 1
    fi
    
    # Extract run ID
    local run_id
    run_id=$(echo "$selected_run" | awk '{print $1}')
    
    # Get jobs for selected run
    local jobs_data
    jobs_data=$(gh run view "$run_id" --json 'jobs')
    
    # Select job with fzf
    local selected_job
    selected_job=$(echo "$jobs_data" | jq -r '.jobs[] | "\(.databaseId) \(.name) \(.status) \(.conclusion // "null")"' | \
        fzf --preview "echo '$jobs_data' | jq -r '.jobs[] | select(.databaseId == {1}) | \"Job ID: \" + (.databaseId | tostring) + \"\nName: \" + .name + \"\nStatus: \" + .status + \"\nConclusion: \" + (.conclusion // \"null\") + \"\nStarted: \" + (.startedAt // \"null\") + \"\nCompleted: \" + (.completedAt // \"null\")'" \
        --preview-window=right:50%)
    
    if [[ -z "$selected_job" ]]; then
        echo "No job selected"
        return 1
    fi
    
    # Extract job ID and show logs
    local job_id
    job_id=$(echo "$selected_job" | awk '{print $1}')
    
    echo "Showing logs for job $job_id:"
    gh run view --job "$job_id" --log
}
