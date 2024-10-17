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