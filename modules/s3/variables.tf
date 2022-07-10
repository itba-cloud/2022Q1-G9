variable "src" {
  description = "Bucket files source"
  type        = string
}

variable "name" {
  description = "Bucket name"
  type        = string
}

variable "aws_region" {
  description = "AWS Region in which to deploy the application"
  type        = string
}

variable "bucket_access_OAI" {
  description = "OAI of authorized bucket accessors"
  type        = list(string)
}
