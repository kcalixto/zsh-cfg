aws_logs() {
    local log_group
    local log_stream
    log_group=$(aws logs describe-log-groups --region sa-east-1 | jq -r ".logGroups[].logGroupName" | fzf --preview '')
    option=$(echo -e "search\ntail" | fzf --preview '')

    if [ "$option" = "search" ]; then
        log_stream=$(aws logs describe-log-streams --region sa-east-1 --log-group-name "$log_group" --max-items 5 --order-by LastEventTime --descending | jq -r '.logStreams[].logStreamName' | fzf --preview '')
        aws logs get-log-events --log-stream-name "$log_stream" --log-group-name "$log_group" --region sa-east-1 | jq ".events[].message" | fzf --preview 'echo {}' --preview-window wrap
    elif [ "$option" = "tail" ]; then
        aws logs tail $log_group --follow --region sa-east-1 --since 1h --format json
    else
        echo "Invalid option"
    fi
}
