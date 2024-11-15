#!/bin/bash

# Function to prompt for a value with an example
prompt() {
    local var_name="$1"
    local example="$2"
    read -p "Enter the value for $var_name (e.g., $example): " value
    echo "$value"
}

# Initialize variables by prompting the user for each one with examples
PROJECT_NAME=$(prompt "PROJECT_NAME" "measurely")
REGION=$(prompt "REGION" "ap-south-1 for Mumbai, ap-southeast-2 for Sydney")
TABLE_NAME=$(prompt "TABLE_NAME" "terraform-state-locking")

# Create DynamoDB table with custom settings
aws dynamodb create-table \
    --table-name $TABLE_NAME \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --sse-specification Enabled=true,SSEType=KMS,KeyId="alias/aws/dynamodb" \
    --tags Key=Name,Value=$PROJECT_NAME \
    --region $REGION

# Output the creation result
if [ $? -eq 0 ]; then
  echo "DynamoDB table '$TABLE_NAME' created successfully."
else
  echo "Failed to create DynamoDB table '$TABLE_NAME'."
fi
