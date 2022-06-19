data "aws_route53_zone" "this" {
  name = var.base_domain
}

resource "aws_route53_record" "cloudfront" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.base_domain
  type    = "A"

  alias {
    name    = var.cloudfront_dist.domain_name
    zone_id = var.cloudfront_dist.hosted_zone_id
    evaluate_target_health = false
  }
}