module "this" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "3.1.0"

  count = var.enable ? 1 : 0

  function_name = local.function_name
  description   = var.descripion
  handler       = local.handler
  runtime       = var.runtime

  memory_size   = 128
  timeout       = 5

  publish       = true

  store_on_s3   = true
  s3_bucket     = var.s3_bucket

  vpc_subnet_ids         = [var.VPC_SUBNET_ID]
  vpc_security_group_ids = [var.VPC_SECURITY_GROUP_ID]

  source_path = [
    {
      path = "${path.module}/../..",
      commands = [
        var.cmd_cd_dist_path,
        ":zip"
      ]
    }
  ]

  create_role = false
  lambda_role = aws_iam_role.iam_lambda_access_role.arn

  tags = var.tags

  depends_on = [aws_iam_role.iam_lambda_access_role]
}
