variable "tags" {
  description = "Tags to apply to the keys"
  type        = map(string)
}

variable "account_id" {
  description = "AWS Account Number"
  type        = string
}
