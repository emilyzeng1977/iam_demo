module "this" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "3.1.0"

  count = var.enable ? 1 : 0

  function_name = var.function_name
  description   = var.descripion
  handler       = var.handler
  runtime       = var.runtime

  memory_size   = 128
  timeout       = 5

  publish       = true

  store_on_s3   = true
  s3_bucket     = var.s3_bucket

  vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids

  source_path = [
    {
      path = "${path.module}/../..",
      commands = [
        var.dist_path,
        ":zip"
      ]
    }
  ]

  lambda_role = aws_iam_role.iam_lambda_access_role.arn

  tags = var.tags

  depends_on = [aws_iam_role.iam_lambda_access_role]
}
