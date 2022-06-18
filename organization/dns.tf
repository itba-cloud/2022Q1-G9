resource "aws_route53_record" "cloudfront" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "${var.base_domain}"
  type    = "A"

  alias {
    name    = aws_cloudfront_distribution.api_gateway.domain_name
    zone_id = aws_cloudfront_distribution.api_gateway.hosted_zone_id
    evaluate_target_health = false
  }
}