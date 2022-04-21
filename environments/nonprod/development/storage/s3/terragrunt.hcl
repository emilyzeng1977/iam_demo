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
  env_vars = read_terragrunt_config(find_in_parent_folders())
  zone_name = "platform.dev.identitii.com"
}

//  custom_domain_name = "sftp.${local.zone_name}"

inputs = {
  buckets     = ["iam-lambdas"]
  account_id  = get_aws_account_id()
//  kms_key_arn = dependency.kms.outputs.s3_key_arn


  tags = {
    "Managed By" = "Terragrunt"
  }
}
