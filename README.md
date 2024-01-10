# Configuration to Cognito and API Gateway

## Overview
This repository contains Terraform configuration files for setting up and managing an AWS infrastructure focused on AWS Cognito. It is designed to demonstrate the integration of AWS Cognito with an AWS API Gateway REST API, exemplified by a "petstore" application.

## Features
- **AWS Cognito Configuration**: Establishes a Cognito service with domain, OAuth scopes, callback URLs, and logout URLs.
- **API Gateway Integration**: Defines a REST API with Cognito-based authorization.
- **Cognito Resource Server**: Configures a resource server in Cognito with specific scopes.
- **Cognito User Pool Client**: Creates a Cognito user pool client for the "petstore" application.
- **Cognito User**: Sets up a test user in Cognito.

## Repository Structure
- `main.tf`: Main Terraform file with basic configuration.
- `variables.tf`: Defines variables used in the configurations.
- `cognito.tf`: Specific configuration for the AWS Cognito service.
- `petstore-api.tf`: Configurations for the REST API via AWS API Gateway.
- `petstore-client.tf`: Configurations for the Cognito client in the "petstore" application.
- `petstore-user.tf`: Creates a sample user in Cognito.
- `dev.tfvars`: Variables for the development environment.
- `modules/`: Contains Terraform modules, like the auth module for authentication.

## Prerequisites
- Terraform v1.6.5 or higher.
- AWS CLI configured with appropriate credentials.

## How to Use
1. **Clone the Repository**: Clone this repository to your local environment.
2. **AWS Profile Configuration**: If you plan to use the existing variables, ensure you have an AWS profile named **"tf014"** in your AWS credentials. Otherwise, you will need to modify the `aws_profile` variable in dev.tfvars to match the name of the profile you wish to use.
3. **Terraform Initialization**: Navigate to the repository directory and run terraform init to initialize Terraform and install necessary modules and providers.
4. **Terraform Planning**: Before applying the changes, run `terraform plan -var-file="dev.tfvars"` to review the changes that will be made to your infrastructure.
5. **Applying Configurations**: Finally, apply the configurations with `terraform apply -var-file="dev.tfvars"`.
