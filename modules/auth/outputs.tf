output "cognito_user_pool_id" {
  description = "ID do pool de usuários do Cognito"
  value       = aws_cognito_user_pool.cognito_user_pool.id
}

output "cognito_user_pool_arn" {
  description = "ARN do pool de usuários do Cognito"
  value       = aws_cognito_user_pool.cognito_user_pool.arn
}

output "openid_config" {
  description = "Configuração do OpenID"
  value       = "https://${aws_cognito_user_pool.cognito_user_pool.endpoint}/.well-known/openid-configuration"
}