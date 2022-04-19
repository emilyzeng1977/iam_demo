module "s3_kms" {
  source  = "cloudposse/kms-key/aws"
  version = "0.12.1"

  namespace               = "id8"
  name                    = "s3"
  description             = "KMS key for s3"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  alias                   = "alias/s3"

  policy = data.aws_iam_policy_document.s3_kms_access.json

  tags = var.tags
}

data "aws_iam_policy_document" "s3_kms_access" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt",
      "kms:Encrypt"
    ]
    resources = ["*"]
  }
}

output "s3_key_arn" {
  value = module.s3_kms.key_arn
}
output "s3_key_alias_arn" {
  value = module.s3_kms.alias_arn
}
