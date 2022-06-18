
data "aws_cloudfront_cache_policy" "optimized" {
    name = "Managed-CachingOptimized"
}

data "aws_cloudfront_cache_policy" "disabled" {
    name = "Managed-CachingDisabled"
}


resource "aws_cloudfront_distribution" "api_gateway" {
    # https://p2kjiyku4m.execute-api.us-east-1.amazonaws.com/
  origin {
    domain_name = join(".", [aws_api_gateway_rest_api.this.id, "execute-api", var.aws_region, "amazonaws.com"])
    origin_id   = "api_gateway"
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols=  ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "api Gateway"

  aliases = ["cloud.franciscobernad.com.ar"]

 
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "api_gateway"
    cache_policy_id  = data.aws_cloudfront_cache_policy.optimized.id

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
  }

  # Cache behavior with precedence 0
  # ordered_cache_behavior {
  #   path_pattern     = "/api/*"
  #   allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #   cached_methods   = ["GET", "HEAD", "OPTIONS"]
  #   cache_policy_id  = data.aws_cloudfront_cache_policy.disabled.id
  #   target_origin_id = aws_api_gateway_rest_api.this.id

  #   min_ttl                = 0
  #   compress               = true
  #   viewer_protocol_policy = "redirect-to-https"
  # }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "api gateway cdn"
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true

    acm_certificate_arn = aws_acm_certificate.this.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       =  "sni-only"
  }
}