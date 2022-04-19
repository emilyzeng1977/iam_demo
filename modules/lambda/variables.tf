variable "enable" {
  description = "Toggle to use or not use the event-publisher"
  type        = bool
  default     = true
}

variable "function_name" {
  description = "A unique name for your Lambda Function"
  type        = string
  default     = ""
}

variable "descripion" {
  description = "Description for your Lambda Function"
  type        = string
  default     = ""
}

variable "handler" {
  description = "Lambda Function entrypoint in your code"
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

variable "tags" {
  description = "Tags to apply to the keys"
  type        = map(string)
}
