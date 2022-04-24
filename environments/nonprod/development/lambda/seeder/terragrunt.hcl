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
  env_vars = read_terragrunt_config(find_in_parent_folders())
}

inputs = {
  handler   = "seeder"
  service  = local.env_vars.locals.service
  description   = "Seeder service"
  runtime       = "go1.x"
  dist_path     = "dist/seeder_linux_amd64",

  store_on_s3   = true
  s3_bucket     = dependency.s3.outputs.buckets["iam-lambdas"]["s3_bucket_id"]

  account_id    = get_aws_account_id()

  tags = {
    "Managed By" = "Terragrunt"
  }
}
