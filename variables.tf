# Provider
variable "aws_region" {
  type        = string
  description = "AWS region where the resources will be deployed"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile to be used for deployment"
  default     = "default"
}

# Cognito
variable "cognito_service_name" {
  type        = string
  description = "Name of the Cognito service for identification"
}

variable "cognito_service_domain" {
  type        = string
  description = "Domain name for the Cognito service"
}

variable "callback_urls" {
  description = "List of allowed callback URLs for the user pool client."
  type        = list(string)
}

variable "logout_urls" {
  description = "List of allowed logout URLs for the user pool client."
  type        = list(string)
}

variable "allowed_oauth_scopes" {
  description = "List of allowed scopes for the application"
  type        = list(string)
}

# PetStore - Client
variable "refresh_token_validity" {
  description = "Refresh token validity period"
  type        = number
  default     = 30
}

variable "cognito_petstore_client_name" {
  description = "Name of the Cognito service"
  type        = string
}

# PetStore API
variable "petstore-api-name" {
  description = "Name of the PetStore API for identification and reference"
  type        = string
}

variable "petstore-uri" {
  description = "URI endpoint for the PetStore API services"
  type        = string
}