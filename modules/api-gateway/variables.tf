variable "rest_api_name" {
  description = "Name of the REST API"
  type        = string
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

variable "authorizations" {
  description = "The type of authorization used for the method (NONE, CUSTOM, AWS_IAM, COGNITO_USER_POOLS)"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the keys."
  type        = map(string)
}
