include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/lambda"
}

dependency "s3" {
  config_path = "../../storage/s3"
}

inputs = {
  function_name = "authorizer"
  description   = "Authorizer service"
  handler       = "authorizer"
  runtime       = "go1.x"

  store_on_s3   = true
  s3_bucket     = dependency.s3.outputs.buckets["iam-lambdas"]["s3_bucket_id"]

  tags = {
    "Managed By" = "Terragrunt"
  }
}
