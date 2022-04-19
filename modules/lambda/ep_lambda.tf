module "event_publisher" {
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

  source_path = [
    {
      path = "${path.module}/../..",
      commands = [
        "cd dist/authorizer_linux_amd64",
        ":zip"
      ]
    }
  ]

  attach_policy = true
  policy        = "arn:aws:iam::aws:policy/AWSLambdaInvocation-DynamoDB"

  tags = var.tags
}
