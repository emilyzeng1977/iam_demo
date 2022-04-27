resource "aws_api_gateway_rest_api" "api" {
  name        = var.rest_api_name
  description = var.rest_api_description
  tags        = var.tags
}

resource "aws_api_gateway_resource" "version" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.api_version
}

resource "aws_api_gateway_resource" "resources" {
  count = length(var.path_parts) > 0 ? length(var.path_parts) : 0

  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.version.id
  path_part   = var.path_parts[count.index]
}

resource "aws_api_gateway_method" "methods" {
  count = length(var.path_parts) > 0 ? length(var.path_parts) : 0

  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resources[count.index].id
  http_method   = element(var.http_methods, count.index)
  authorization = length(var.authorizations) > 0 ? element(var.authorizations, count.index) : "NONE"
}

resource "aws_api_gateway_integration" "integrations" {
  count = length(var.path_parts) > 0 ? length(var.path_parts) : 0

  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resources[count.index].id
  http_method             = aws_api_gateway_method.methods[count.index].http_method
  integration_http_method = var.integration_http_methods[count.index]
  type                    = "AWS"
  passthrough_behavior    = "NEVER"
  uri                     = format("arn:aws:apigateway:%s:states:action/%s", var.aws_region, var.uri_list[count.index])

  request_templates = {
    "application/json" = data.template_file.request_templates[count.index].rendered
  }

  credentials = aws_iam_role.iam_execution_roles[count.index].arn

  depends_on = [aws_iam_role.iam_execution_roles]
}

resource "aws_api_gateway_deployment" "default" {
  rest_api_id       = aws_api_gateway_rest_api.api.id
  depends_on = [aws_api_gateway_integration.integrations]
}

resource "aws_api_gateway_stage" "default" {
  count = length(var.path_parts) > 0 ? length(var.path_parts) : 0

  rest_api_id           = aws_api_gateway_rest_api.api.id
  deployment_id         = aws_api_gateway_deployment.default.*.id[0]
  stage_name            = element(var.stage_names, count.index)
  variables             = length(var.stage_variables) > 0 ? element(var.stage_variables, count.index) : {}
}

data "template_file" "request_templates" {
  count = length(var.path_parts) > 0 ? length(var.path_parts) : 0

  template = file(format("template/%s.tpl", var.template_list[count.index]))
  vars = {
    new_customer_state_machine_arn = var.aws_service_arn_list[count.index]
  }
}
