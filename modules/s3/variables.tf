variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

//variable "kms_key_arn" {
//  description = "ARN of KMS key to encrypt with"
//  type        = string
//}

variable "buckets" {
  description = "List of buckets to create. '-<accountid>.identitii.com' will be appended"
  type        = list(string)
  default     = ["incoming", "errors"]
}

variable "tags" {
  description = "Tags to apply to buckets"
  type        = map(string)
  default = {
    "Managed By" = "Terraform"
  }
}
