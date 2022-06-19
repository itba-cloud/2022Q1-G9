# ---------------------------------------------------------------------------
# Main resources
# ---------------------------------------------------------------------------
module "vpc" {
      source = "../modules/vpc"

      cidr_block = local.aws_vpc_cidr
      az_count = local.aws_vpc_az_count
}

module "cerificate" {
      source = "../modules/certificate"

      base_domain = var.base_domain
}

module "dns" {
      source = "../modules/dns"

      base_domain = var.base_domain
      cloudfront_dist = module.cdn.cloudfront_distribution
}

resource "aws_cloudfront_origin_access_identity" "cdn" {
  comment = "Cloudfront OAI"
}

module "cdn" {
      source = "../modules/cdn"

      api_domain_name = module.api_gateway.domain_name
      api_origin_id = "api"

      s3_domain_name = module.s3.domain_name
      s3_origin_id = "frontend"

      OAI = aws_cloudfront_origin_access_identity.cdn

      comment = "main CDN"
      aliases = [var.base_domain, "*.${var.base_domain}"]
      tags = {
            Name = "main CDN"
      }
      certificate_arn = module.cerificate.arn
}

module "s3" {
      source = "../modules/s3"
      src = local.bucket_source
      name = local.bucket_name
      aws_region = var.aws_region
      bucket_access_OAI = [aws_cloudfront_origin_access_identity.cdn.iam_arn]
}

module "api_gateway" {
      source = "../modules/api_gateway"

      aws_region= var.aws_region
      aws_account_id = local.aws_account_id
      base_domain = var.base_domain
      cloudfront_dist = module.cdn.cloudfront_distribution
      lambda = module.lambda.function
}

module "lambda" {
      source = "../modules/lambda"

      function_name = local.lambda_name
      filename      = "${local.lambda_source}/lambdacode.zip"
      handler       = local.lambda_handler
      runtime       = local.lambda_runtime
      aws_authorized_role = var.aws_authorized_role

      subnet_ids = module.vpc.private_subnets_ids
      vpc_id = module.vpc.id
      tags = {
            Name = "Test Lambda"
      }
}


