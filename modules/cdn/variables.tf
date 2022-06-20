variable s3_domain_name{
  description = "Cloudfront distribution domain name for s3"
  type = string
}

variable s3_origin_id{
  description = "Cloudfront distribution origin id for s3"
  type = string
}

variable api_domain_name{
  description = "Cloudfront distribution domain name for api gateway"
  type = string
}

variable api_origin_id{
  description = "Cloudfront distribution origin id for api gateway"
  type = string
}

variable comment{
  description = "Cloudfront distribution comment"
  type = string
}

variable aliases{
  description = "Cloudfront distribution aliases"
  type = list(string)
}

variable tags{
  description = "Cloudfront distribution aliases"
  type = map(any)
}

variable certificate_arn{
  description = "Cloudfront distribution certificate arn"
  type = string
}

variable "OAI" {
  description = "OAI"
  type        = map(any)
}

variable "api_secret_header" {
  description = "Header where secret between API and CDN"
  type        = string
}

variable "api_secret" {
  description = "Secret between API and CDN"
  type        = string
}
