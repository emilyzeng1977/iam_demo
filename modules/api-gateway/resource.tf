resource "aws_api_gateway_resource" "version" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_iam.id
  parent_id   = aws_api_gateway_rest_api.rest_api_iam.root_resource_id
  path_part   = var.api_version
}

resource "aws_api_gateway_resource" "api_resources" {
  count = length(var.path_parts) > 0 ? length(var.path_parts) : 0

  rest_api_id = aws_api_gateway_rest_api.rest_api_iam.id
  parent_id   = aws_api_gateway_resource.version.id
  path_part   = element(var.path_parts, count.index)
}

resource "aws_api_gateway_method" "api_methods" {
  count = length(var.path_parts) > 0 ? length(var.path_parts) : 0

  rest_api_id   = aws_api_gateway_rest_api.rest_api_iam.id
  resource_id   = aws_api_gateway_resource.api_resources.id
  http_method   = element(var.http_methods, count.index)
  authorization = length(var.authorizations) > 0 ? element(var.authorizations, count.index) : "NONE"
}
