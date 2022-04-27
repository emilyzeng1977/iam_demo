variable "service" {
  description = "Service name for your Lambda"
  type        = string
  default     = ""
}

variable "stage" {
  description = "Stage for your Lambda"
  type        = string
}

variable "aws_region" {
  description = "AWS region for your Lambda"
  type        = string
}

variable "rest_api_name" {
  description = "Name of the REST API"
  type        = string
  default     = "dev-tf-iam"
}

variable "rest_api_description" {
  description = "Description of the REST API"
  type        = string
  default     = ""
}

variable "api_version" {
  description = "Version of the REST API"
  type        = string
  default     = "v1"
}

variable "path_parts" {
  description = "The last path segment of this API resource"
  type        = list(any)
  default     = []
}

variable "http_methods" {
  description = "The HTTP Method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY)"
  type        = list(any)
  default     = []
}

variable "integration_http_methods" {
  description = "Integration Http Method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY)"
  type        = list(any)
  default     = []
}

variable "uri_list" {
  description = "URI list"
  type        = list(any)
  default     = []
}

variable "template_list" {
  description = "template list"
  type        = list(any)
  default     = []
}

variable "aws_service_arn_list" {
  description = "AWS service arn list"
  type        = list(any)
  default     = []
}

variable "iam_execution_roles" {
  description = "API gateway role execution list"
  type        = list(any)
  default     = []
}

variable "stage_variables" {
  type        = list(any)
  description = "A map that defines the stage variables."
  default     = []
}

variable "authorizations" {
  description = "The type of authorization used for the method (NONE, CUSTOM, AWS_IAM, COGNITO_USER_POOLS)"
  type        = list(any)
  default     = []
}

variable "stage_names" {
  description = "The stage name list"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the keys"
  type        = map(string)
}
