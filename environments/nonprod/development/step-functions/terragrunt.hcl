include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/step-functions"
}

//dependency "s3" {
//  config_path = "../../storage/s3"
//}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders())
}

inputs = {
  tags = {
    "Managed By" = "Terragrunt"
  }
}
