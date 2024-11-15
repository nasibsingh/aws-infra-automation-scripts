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
BUCKET_NAME=$(prompt "BUCKET_NAME" "terraform-state-bucket")
REGION=$(prompt "REGION" "ap-south-1 for Mumbai, ap-southeast-2 for Sydney")

# Define the log directory and file
LOG_DIR="logs/$PROJECT_NAME"
LOG_FILE="$LOG_DIR/s3_bucket_creation.log"

# Create the log directory if it does not exist
mkdir -p $LOG_DIR

# Start logging
log_message "Starting S3 bucket creation script for project: $PROJECT_NAME"

# Create the S3 bucket
log_message "Creating S3 bucket: $BUCKET_NAME in region: $REGION"
aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION 2>&1 | tee -a $LOG_FILE

# Enable versioning
log_message "Enabling versioning for bucket: $BUCKET_NAME"
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled 2>&1 | tee -a $LOG_FILE

# Enable SSE-S3 encryption with Bucket Key disabled
log_message "Setting SSE-S3 encryption for bucket: $BUCKET_NAME"
aws s3api put-bucket-encryption --bucket $BUCKET_NAME --server-side-encryption-configuration '{
    "Rules": [
        {
            "ApplyServerSideEncryptionByDefault": {
                "SSEAlgorithm": "AES256"
            },
            "BucketKeyEnabled": false
        }
    ]
}' 2>&1 | tee -a $LOG_FILE

# Disable Object Lock
log_message "Disabling Object Lock for bucket: $BUCKET_NAME"
aws s3api put-object-lock-configuration --bucket $BUCKET_NAME --object-lock-configuration '{
    "ObjectLockEnabled": "Disabled"
}' 2>&1 | tee -a $LOG_FILE

log_message "S3 bucket setup completed successfully."
