variable "enable" {
  description = "Toggle to use or not use the event-publisher"
  type        = bool
  default     = true
}

variable "service_name" {
  description = "Service name for your Lambda"
  type        = string
  default     = ""
}

variable "SLS_STAGE" {
  description = "SLS stage for your Lambda"
  type        = string
}

variable "lambda_name" {
  description = "A unique name for your Lambda"
  type        = string
  default     = ""
}

variable "descripion" {
  description = "Description for your Lambda Function"
  type        = string
  default     = ""
}

variable "runtime" {
  description = "Lambda Function runtime"
  type = string
  default = ""
}

variable "s3_bucket" {
  description = "S3 Bucket for storing lambda releases"
  type        = string
}

variable "VPC_SUBNET_ID" {
  description = "Subnet id when Lambda Function should run in the VPC. Usually private or intra subnets."
  type        = string
}

variable "VPC_SECURITY_GROUP_ID" {
  description = "Security group ids when Lambda Function should run in the VPC."
  type        = string
}

variable "lambda_role" {
  description = "IAM role ARN attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details."
  type        = string
  default     = ""
}

variable "dist_path" {
  description = "It's the dist path."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the keys."
  type        = map(string)
}

locals {
  function_name    = format("%s-%s-%s", var.service_name, var.SLS_STAGE, var.lambda_name)
  handler          = format("%s/%s", var.dist_path, var.lambda_name)
  cmd_cd_dist_path = format("cd %s", var.dist_path)
}
