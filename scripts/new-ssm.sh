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