aws_ssm_create() {
    AWS_REGION="sa-east-1"
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Please provide the ssm name and value. Example: aws_ssm_create /some/name my_value"
        exit 1
    fi

    name="$1"
    value="$2"

    if aws ssm get-parameter --name "$name" --region $AWS_REGION &> /dev/null; then
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