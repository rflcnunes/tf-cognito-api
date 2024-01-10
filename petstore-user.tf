resource "aws_cognito_user" "testuser" {
  user_pool_id       = module.tf-cgnt-api.cognito_user_pool_id
  username           = "usuario-teste"
  temporary_password = "Senha@1234!"
  enabled            = true

  attributes = {
    email          = "email@teste.com"
    email_verified = true
  }
}