resource "aws_iam_role" "iam_lambda_access_role" {
  name               = local.lambda_role_name
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
    name = local.inline_policy_name

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["logs:CreateLogStream",
                      "logs:CreateLogGroup",
                      "logs:PutLogEvents"]
          Resource = "arn:aws:logs:ap-southeast-2:204532658794:log-group:/aws/lambda/iam-dev-seeder:*:*"
          Effect   = "Allow"
        },
        {
          Action   = ["ssm:GetParameters"]
          Resource = "arn:aws:ssm:ap-southeast-2:204532658794:parameter/dev/*"
          Effect   = "Allow"
        }
      ]
    })
  }
}
