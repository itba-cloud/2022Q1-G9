
data "aws_cloudfront_cache_policy" "optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_cache_policy" "disabled" {
  name = "Managed-CachingDisabled"
}

resource "aws_cloudfront_distribution" "main" {

  origin {
    domain_name = var.s3_domain_name
    origin_id   = var.s3_origin_id

    s3_origin_config {
      origin_access_identity = var.OAI.cloudfront_access_identity_path
    }
  }
  origin {
    domain_name = var.api_domain_name
    origin_id   = var.api_origin_id

    custom_header {
      name  = var.api_secret_header
      value = var.api_secret
    }
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled         = true
  is_ipv6_enabled = false

  default_root_object = "index.html"

  comment = var.comment

  aliases = length(var.aliases) > 0 ? var.aliases : []

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_origin_id
    cache_policy_id  = data.aws_cloudfront_cache_policy.optimized.id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/api/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    cache_policy_id  = data.aws_cloudfront_cache_policy.disabled.id
    target_origin_id = var.api_origin_id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = var.tags

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}