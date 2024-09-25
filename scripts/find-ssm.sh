aws_ssm_find() {
    AWS_REGION="sa-east-1"
    name="$1"
    value=$(aws ssm get-parameter --name "$name" --query 'Parameter.Value' --output text --with-decryption --region $AWS_REGION)
    echo "$name\n\n$value"
}