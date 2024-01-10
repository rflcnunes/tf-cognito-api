# AWS Configuration
aws_region             = "us-east-1"
aws_profile            = "tf014"

# Cognito Service Configuration
cognito_service_name   = "tf-cognt"
cognito_service_domain = "tf-cognt-domain"

# Cognito Callback and Logout URLs
callback_urls          = ["https://example.com/callback", "https://oauth.pstmn.io/v1/callback"]
logout_urls            = ["https://example.com/logout", "https://oauth.pstmn.io/v1/callback"]

# OAuth Scopes
allowed_oauth_scopes   = ["openid", "profile", "petstore/pets"]
