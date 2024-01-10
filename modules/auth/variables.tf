variable "cognito_service_name" {
  type        = string
  description = "Name of the Cognito service"
}

variable "cognito_service_domain" {
  type        = string
  description = "Domain of the Cognito service"
}

variable "mfa_status" {
  type        = string
  description = "MFA status"
  default     = "OFF"
}

variable "refresh_token_validity" {
  description = "Refresh token validity period"
  type        = number
  default     = 30
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
  description = "List of allowed OAuth scopes for the user pool client."
  type        = list(string)
  default     = ["openid", "profile"]
}

variable "deletion_protection" {
  description = "Status of the deletion protection for the user pool"
  type        = bool
  default     = true
}
