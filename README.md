AWS Infrastructure Automation Scripts
=====================================

This repository contains shell scripts to automate the creation and configuration of essential AWS infrastructure components, such as S3 buckets and DynamoDB tables. The scripts are designed to streamline the setup process, including project-specific logging for better tracking and debugging.

Table of Contents
-----------------

*   [Overview](#overview)
    
*   [Directory Structure](#directory-structure)
    
*   [Prerequisites](#prerequisites)
    
*   [Usage](#usage)
    
    *   [Creating an S3 Bucket](#creating-an-s3-bucket)
        
    *   [Creating a DynamoDB Table](#creating-a-dynamodb-table)
        
*   [Logging](#logging)
    
*   [Configuration](#configuration)
    
*   [Contributing](#contributing)
    
*   [License](#license)
    

Overview
--------

The **AWS Infrastructure Automation Scripts** project automates common AWS resource setup tasks. With built-in logging and user prompts, it provides a user-friendly way to manage AWS resources efficiently.

Directory Structure
-------------------

aws-infra-automation-scripts/  
│
├── README.md                      # Documentation about the project  
├── LICENSE                        # License file (if applicable)  
│
├── scripts/                       # Directory for all the script files  
│   ├── create_s3_bucket.sh        # Script for S3 bucket creation  
│   ├── create_dynamodb_table.sh   # Script for DynamoDB table creation  
│   └── common_functions.sh        # Common functions like logging (if shared)  
│
├── logs/                          # Directory for logs  
│   └── <project-name>/            # Subdirectories for each project name  
│       ├── s3_bucket_creation.log # Log file for S3 bucket creation  
│       └── dynamodb_table_creation.log  # Log file for DynamoDB table creation  
│
├── config/                        # Configuration files (optional)
│   └── example-config.env         # Example environment configuration file
│
└── docs/                          # Documentation resources (if needed)
    └── setup_guide.md             # Guide for setting up and using the scripts

Prerequisites
-------------

*   **AWS CLI**: Ensure you have the AWS Command Line Interface (CLI) installed and configured with your AWS credentials.
    
*   **Bash Shell**: The scripts are written in Bash, so you should have a compatible shell environment.
    
*   **AWS Permissions**: Make sure the AWS profile you use has the necessary permissions to create S3 buckets and DynamoDB tables.
    

Usage
-----

### Creating an S3 Bucket

1.  bashCopy codebash scripts/create\_s3\_bucket.sh
    
2.  Follow the prompts to provide the project name, bucket name, and region.
    
3.  The script will create the S3 bucket with versioning and server-side encryption enabled, and log the details in logs//s3\_bucket\_creation.log.
    

### Creating a DynamoDB Table

1.  bashCopy codebash scripts/create\_dynamodb\_table.sh
    
2.  Follow the prompts to provide the project name, region, and table name.
    
3.  The script will create the DynamoDB table with the specified settings and log the details in logs//dynamodb\_table\_creation.log.
    

Logging
-------

*   **Project-Specific Logs**: Logs are stored in the logs/ directory, organized by project name.
    
*   Each script logs its operations, including timestamps, for easy tracking and debugging.
    
*   Example log paths:
    
    *   logs//s3\_bucket\_creation.log
        
    *   logs//dynamodb\_table\_creation.log
        

Configuration
-------------

If you have environment-specific configurations, you can use the config/ directory to store environment files or any other configuration settings. An example file, example-config.env, is provided as a template.

Contributing
------------

Contributions are welcome! Please fork this repository and submit a pull request with your changes. Make sure to follow the existing coding style and include relevant documentation.

License
-------

This project is licensed under the MIT License. Feel free to use, modify, and distribute the scripts as needed.
