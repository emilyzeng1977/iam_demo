include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/api-gateway"
}

dependencies {
  paths = ["../step-functions"]
}

dependency "step-functions" {
  config_path = "../step-functions"
}

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  path_parts   = ["customers"]
  http_methods = ["POST"]
  integration_http_methods = ["POST"]
  uri_list = ["StartExecution"]
  template_list = ["new_customer_state_machine"]
  aws_service_arn_list = [dependency.step-functions.outputs.state_machine_arn]
  iam_execution_roles = ["StepFunctionsRole"]
  stage_names = ["dev"]

  aws_region = local.region_vars.locals.aws_region
  stage   = local.env_vars.locals.SLS_STAGE

  tags = {
    "Managed By" = "Terragrunt"
  }
}
