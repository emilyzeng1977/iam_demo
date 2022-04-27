include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/lambda"
}

dependency "s3" {
  config_path = "../../storage/s3"
}

locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  handler       = "seeder"
  description   = "Seeder service"
  runtime       = "go1.x"
  dist_path     = "dist/seeder_linux_amd64",

  service   = local.env_vars.locals.SERVICE
  stage   = local.env_vars.locals.SLS_STAGE
  vpc_security_group_id = local.env_vars.locals.VPC_SECURITY_GROUP_ID
  vpc_subnet_id = local.env_vars.locals.VPC_SUBNET_ID
  aws_region = local.region_vars.locals.aws_region
  account_id  = local.account_vars.locals.aws_account_id

  store_on_s3   = true
  s3_bucket     = dependency.s3.outputs.buckets["iam-lambdas"]["s3_bucket_id"]

  timeout       = 120
  tracing_mode  = "Active"

  tags = {
    "Managed By" = "Terragrunt"
  }
}
