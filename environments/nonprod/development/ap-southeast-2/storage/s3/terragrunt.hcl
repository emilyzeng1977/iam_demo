include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/s3"
}

//dependencies {
//  paths = ["../../encryption/kms"]
//}
//
//dependency "kms" {
//  config_path = "../../encryption/kms"
//}

locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
}

inputs = {
  buckets     = ["iam-lambdas"]
  account_id  = local.account_vars.locals.aws_account_id
//  kms_key_arn = dependency.kms.outputs.s3_key_arn

  tags = {
    "Managed By" = "Terragrunt"
  }
}
