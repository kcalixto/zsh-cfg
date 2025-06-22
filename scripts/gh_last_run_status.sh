gh_last_run_status() {
  # Fetch the last run status for the current branch
  gh run view $(gh run list --branch $(git branch --show-current) --limit 1 --jq '.[0]' --json 'createdAt,event,status,databaseId' | jq -r '.databaseId')
}
