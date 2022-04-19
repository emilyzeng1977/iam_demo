module "buckets" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.14.1"

  for_each = toset(var.buckets)

  bucket                  = "${each.key}-${var.account_id}.identitii.com"
  acl                     = "private"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  versioning = {
    enabled = true
  }

//  server_side_encryption_configuration = {
//    rule = {
//      apply_server_side_encryption_by_default = {
//        kms_master_key_id = var.kms_key_arn
//        sse_algorithm     = "aws:kms"
//      }
//    }
//  }

  tags = var.tags
}

output "buckets" {
  value = module.buckets
}
