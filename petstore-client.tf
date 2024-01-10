resource "aws_cognito_resource_server" "petstore_resource_server" {
  identifier = "petstore"
  name       = "Petstore"

  scope {
    scope_name        = "pets"
    scope_description = "Pets"
  }

  user_pool_id = module.tf-cgnt-api.cognito_user_pool_id
}

resource "aws_cognito_user_pool_client" "petstore-client" {
  name         = var.cognito_petstore_client_name
  user_pool_id = module.tf-cgnt-api.cognito_user_pool_id

  generate_secret        = true
  refresh_token_validity = var.refresh_token_validity

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["implicit", "code"]
  explicit_auth_flows                  = ["ALLOW_CUSTOM_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  allowed_oauth_scopes                 = var.allowed_oauth_scopes
  callback_urls                        = var.callback_urls
  logout_urls                          = var.logout_urls

  supported_identity_providers = [
    "COGNITO",
  ]
}