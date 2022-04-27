resource "aws_iam_role" "iam_lambda_access_role" {
  name = local.lambda_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]

  inline_policy {
    name   = local.inline_policy_name
    policy = var.handler == "create-customer" ? data.template_file.iam-policy-create-customer.rendered : data.template_file.iam-policy-template-authorizer.rendered
  }

  depends_on = [data.template_file.iam-policy-create-customer, data.template_file.iam-policy-template-authorizer]
}

data "template_file" "iam-policy-template-authorizer" {
  template = file("template/authorizer.tpl")

  vars = {
    aws_region    = var.aws_region
    account_id    = var.account_id
    stage         = var.stage
    function_name = local.function_name
  }
}

data "template_file" "iam-policy-create-customer" {
  template = file("template/create-customer.tpl")

  vars = {
    aws_region = var.aws_region
    account_id = var.account_id
    service    = var.service
    stage      = var.stage
    kms_key    = local.KMS_KEY
  }
}
