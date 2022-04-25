resource "aws_api_gateway_rest_api" "rest_api_iam" {
  name        = var.rest_api_name
  description = var.rest_api_description
  tags        = var.tags
}
