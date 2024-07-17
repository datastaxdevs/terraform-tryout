variable "astra_token" {
  type = string
}

variable "aws_profile" {
  type     = string
  nullable = true
  default  = null
}

variable "access_key" {
  type     = string
  nullable = true
  default  = null
}

variable "secret_key" {
  type     = string
  nullable = true
  default  = null
}