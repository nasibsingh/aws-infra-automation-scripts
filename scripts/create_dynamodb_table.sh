#!/bin/bash

# Function to prompt for a value with an example
prompt() {
    local var_name="$1"
    local example="$2"
    read -p "Enter the value for $var_name (e.g., $example): " value
    echo "$value"
}

# Function to log messages
log_message() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG_FILE
}

# Initialize variables by prompting the user for each one with examples
PROJECT_NAME=$(prompt "PROJECT_NAME" "measurely")
REGION=$(prompt "REGION" "ap-south-1 for Mumbai, ap-southeast-2 for Sydney")
TABLE_NAME=$(prompt "TABLE_NAME" "terraform-state-locking")

# Define the log directory and file
LOG_DIR="logs/$PROJECT_NAME"
LOG_FILE="$LOG_DIR/dynamodb_table_creation.log"

# Create the log directory if it does not exist
mkdir -p $LOG_DIR

# Start logging
log_message "Starting DynamoDB table creation script for project: $PROJECT_NAME"

# Create DynamoDB table with custom settings
log_message "Creating DynamoDB table: $TABLE_NAME in region: $REGION"
aws dynamodb create-table \
    --table-name $TABLE_NAME \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --sse-specification Enabled=true,SSEType=KMS,KeyId="alias/aws/dynamodb" \
    --tags Key=Name,Value=$PROJECT_NAME \
    --region $REGION 2>&1 | tee -a $LOG_FILE

# Output the creation result and log it
if [ $? -eq 0 ]; then
  log_message "DynamoDB table '$TABLE_NAME' created successfully."
else
  log_message "Failed to create DynamoDB table '$TABLE_NAME'."
fi
