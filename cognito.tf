module "tf-cgnt-api" {
  source                 = "./modules/auth"
  cognito_service_name   = var.cognito_service_name
  cognito_service_domain = var.cognito_service_domain
  allowed_oauth_scopes   = var.allowed_oauth_scopes
  callback_urls          = var.callback_urls
  logout_urls            = var.logout_urls
}