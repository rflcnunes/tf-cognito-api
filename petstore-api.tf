resource "aws_api_gateway_rest_api" "api" {
  name        = var.petstore-api-name
  description = "API para ${var.petstore-api-name}"
}

resource "aws_api_gateway_authorizer" "my_api_authorizer" {
  name            = "CognitoUserPoolAuthorizer"
  type            = "COGNITO_USER_POOLS"
  rest_api_id     = aws_api_gateway_rest_api.api.id
  provider_arns   = [module.tf-cgnt-api.cognito_user_pool_arn]
  identity_source = "method.request.header.Authorization"
}

# Pets Resource -- GET
resource "aws_api_gateway_resource" "pets_res" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "pets"
}

resource "aws_api_gateway_method" "pets_meth" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.pets_res.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.my_api_authorizer.id
}

resource "aws_api_gateway_integration" "pets_int" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.pets_res.id
  http_method             = aws_api_gateway_method.pets_meth.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = var.petstore-uri

  request_parameters = {
    "integration.request.header.Access-Control-Allow-Origin" = "'*'"
  }
}

resource "aws_api_gateway_model" "pet_list_model" {
  rest_api_id  = aws_api_gateway_rest_api.api.id
  name         = "PetListModel"
  description  = "Model for list of pets"
  content_type = "application/json"

  schema = jsonencode({
    type = "array",
    items = {
      type = "object",
      properties = {
        id = {
          type = "integer"
        },
        type = {
          type = "string"
        },
        price = {
          type = "number"
        }
      },
      required = ["id", "type", "price"]
    }
  })
}

resource "aws_api_gateway_method_response" "pets_get_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.pets_res.id
  http_method = aws_api_gateway_method.pets_meth.http_method
  status_code = "200"

  response_models = {
    "application/json" = aws_api_gateway_model.pet_list_model.name
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}


# Pets Resource -- POST
resource "aws_api_gateway_method" "pets_meth_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.pets_res.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.my_api_authorizer.id
}

resource "aws_api_gateway_integration" "pets_int_post" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.pets_res.id
  http_method             = aws_api_gateway_method.pets_meth_post.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = var.petstore-uri
}

# Pet by ID Resource -- GET
resource "aws_api_gateway_resource" "pets_id_res" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.pets_res.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "pets_id_meth" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.pets_id_res.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.my_api_authorizer.id

  request_parameters = {
    "method.request.path.id" = true
  }
}

resource "aws_api_gateway_integration" "pets_id_int" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.pets_id_res.id
  http_method             = aws_api_gateway_method.pets_id_meth.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.petstore-uri}/{id}"

  request_parameters = {
    "integration.request.path.id" = "method.request.path.id"
  }
}

resource "aws_api_gateway_model" "pet_model" {
  rest_api_id  = aws_api_gateway_rest_api.api.id
  name         = "PetModel"
  description  = "Model for pet response"
  content_type = "application/json"

  schema = jsonencode({
    type = "object",
    properties = {
      type  = { type = "string" },
      price = { type = "number" }
    }
  })
}

resource "aws_api_gateway_method_response" "pets_id_get_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.pets_id_res.id
  http_method = aws_api_gateway_method.pets_id_meth.http_method
  status_code = "200"

  response_models = {
    "application/json" = aws_api_gateway_model.pet_model.name
  }
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "v1"

  depends_on = [
    aws_api_gateway_integration.pets_int,
    aws_api_gateway_integration.pets_id_int,
    aws_api_gateway_integration.pets_int_post
  ]
}