include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/api-gateway"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders())
}

inputs = {
  path_parts    = ["customers"]
  http_methods = ["POST"]

  tags = {
    "Managed By" = "Terragrunt"
  }
}
