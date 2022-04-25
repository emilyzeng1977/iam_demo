module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "3.1.0"

  count = var.enable ? 1 : 0

  function_name = local.function_name
  description   = var.descripion
  handler       = var.handler
  runtime       = var.runtime

  memory_size = var.memory_size
  timeout     = var.timeout

  publish = true

  store_on_s3 = true
  s3_bucket   = var.s3_bucket

  vpc_subnet_ids         = [var.VPC_SUBNET_ID]
  vpc_security_group_ids = [var.VPC_SECURITY_GROUP_ID]

  source_path = [
    {
      path = "${path.module}/../..",
      commands = [
        local.cmd_check,
        local.cmd_build,
        local.cmd_cp_otel,
        local.cmd_cd_dist_path,
        ":zip"
      ]
    }
  ]

  environment_variables = {
    ENV_STAGE = var.SLS_STAGE
    ENV_REGION = var.aws_region
    EVENT_TABLE_NAME = "events"
    SSM_ARN = local.SSM_ARN
    AWS_LAMBDA_EXEC_WRAPPER = "/opt/otel-instrument",
    OPENTELEMETRY_COLLECTOR_CONFIG_FILE = "/var/task/otel-collector-config.yaml"
    HONEYCOMB_API_KEY                   = data.aws_ssm_parameter.honeycomb_api_key.value
  }

  create_role = false
  lambda_role = aws_iam_role.iam_lambda_access_role.arn

  layers = compact([local.sdk_layer_arns_amd64])
  tracing_mode = var.tracing_mode

  tags = var.tags

  depends_on = [aws_iam_role.iam_lambda_access_role]
}
