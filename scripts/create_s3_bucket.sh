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
BUCKET_NAME=$(prompt "BUCKET_NAME" "terraform-state-bucket")
REGION=$(prompt "REGION" "ap-south-1 for Mumbai, ap-southeast-2 for Sydney")

# Create the S3 bucket
aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION

# Enable versioning
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled

# Enable SSE-S3 encryption with Bucket Key disabled
aws s3api put-bucket-encryption --bucket $BUCKET_NAME --server-side-encryption-configuration '{
    "Rules": [
        {
            "ApplyServerSideEncryptionByDefault": {
                "SSEAlgorithm": "AES256"
            },
            "BucketKeyEnabled": false
        }
    ]
}'

# Disable Object Lock
aws s3api put-object-lock-configuration --bucket $BUCKET_NAME --object-lock-configuration '{
    "ObjectLockEnabled": "Disabled"
}'
