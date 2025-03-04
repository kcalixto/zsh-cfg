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

aws_ssm_put() {
    AWS_REGION="sa-east-1"
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Please provide the ssm name and value. Example: aws_ssm_put /some/name my_value"
        exit 1
    fi

    name="$1"
    value="$2"
    currvalue=$(aws ssm get-parameter --name "$name" --query 'Parameter.Value' --output text --with-decryption --region $AWS_REGION)

    if [ -n "$currvalue" ]; then
        # checks if the parameter already exists and contains the same value
        if [ "$currvalue" = "$value" ]; then
            echo "Parameter $name already contains the value \"$value\"."
            return 0
        fi

        # shows confirmation message
        echo -e "Are you sure you want to update the parameter $name?\n\"$currvalue\" -> \"$value\"? (y/n)"
        read -r confirm
        if [ "$confirm" != "y" ]; then
            echo "Operation canceled."
            return 0
        fi

        aws ssm put-parameter --name "$name" --value "$value" --type "SecureString" --overwrite --region $AWS_REGION > /dev/null
        echo "Parameter $name updated."
    else
        aws ssm put-parameter --name "$name" --value "$value" --type "SecureString" --region $AWS_REGION > /dev/null
        echo "Parameter $name created."
    fi
}

aws_ssm_find() {
    AWS_REGION="sa-east-1"
    name="$1"
    if [ -z "$name" ]; then
        echo "Please provide the ssm name. Example: aws_ssm_find /some/name"
        return 0
    fi

    value=$(aws ssm get-parameter --name "$name" --query 'Parameter.Value' --output text --with-decryption --region $AWS_REGION)
    echo "$value"
}

aws_ssm_delete() {
    AWS_REGION="sa-east-1"
    name="$1"
    if [ -z "$name" ]; then
        echo "Please provide the ssm name. Example: aws_ssm_delete /some/name"
        return 0
    fi

    value=$(aws ssm get-parameter --name "$name" --query 'Parameter.Value' --output text --with-decryption --region $AWS_REGION)
    if [ -z "$value" ]; then
        echo "Parameter $name not found."
        return 0
    fi

    # shows confirmation message
    echo -e "Are you sure you want to delete the parameter $name?\nParameter value: \"$value\"? (y/n)"
    read -r confirm
    if [ "$confirm" != "y" ]; then
        echo "Operation canceled."
        return 0
    fi

    aws ssm delete-parameter --name "$name" --region $AWS_REGION > /dev/null
    echo "Parameter $name deleted."
}

aws_dynamo_update(){
    tableName="$1"
    if [ -z "$tableName" ]; then
        echo "Please provide the table name. Example: aws_dynamo_update my_table -wcu 5 -rcu 5"
        return 0
    fi

    shift
    wcu=0
    rcu=0

    while [ "$1" != "" ]; do
        case $1 in
            -wcu | --write-capacity-units ) shift
                wcu=$1
                ;;
            -rcu | --read-capacity-units ) shift
                rcu=$1
                ;;
            * ) echo "Invalid argument: $1"
                return 0
        esac
        shift
    done

    if [ $wcu -eq 0 ]; then
        # search for current write capacity units
        wcu=$(aws dynamodb describe-table --table-name "$tableName" --query 'Table.ProvisionedThroughput.WriteCapacityUnits' --output text)
    fi

    if [ $rcu -eq 0 ]; then
        # search for current read capacity units
        rcu=$(aws dynamodb describe-table --table-name "$tableName" --query 'Table.ProvisionedThroughput.ReadCapacityUnits' --output text)
    fi

    # debug
    echo "Table name: $tableName, Write Capacity Units: $wcu, Read Capacity Units: $rcu"
    
    if [ $wcu -eq 0 ] || [ $rcu -eq 0 ]; then
        echo "Error: Invalid capacity units."
        return 0
    fi
    aws dynamodb update-table --table-name "$tableName" --provisioned-throughput WriteCapacityUnits=$wcu,ReadCapacityUnits=$rcu
}
