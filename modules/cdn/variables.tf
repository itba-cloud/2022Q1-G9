variable domain_name{
  description = "Cloudfront distribution domain name"
  type = string
}

variable origin_id{
  description = "Cloudfront distribution origin id"
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