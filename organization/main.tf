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

module "cdn" {
      source = "../modules/cdn"

      domain_name = module.api_gateway.domain_name
      origin_id = module.api_gateway.id
      comment = "main CDN"
      aliases = [var.base_domain]
      tags = {
            Name = "main CDN"
      }
      certificate_arn = module.cerificate.arn
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

      function_name = "test_lambda"
      filename      = "../resources/lambdacode.zip"
      handler       = "lambdacode.handler"
      runtime = "nodejs12.x"
      aws_authorized_role = var.aws_authorized_role

      subnet_ids = module.vpc.private_subnets_ids
      vpc_id = module.vpc.id
      tags = {
            Name = "Test Lambda"
      }
}

module "s3" {
      source = "../modules/s3"

      src               = local.static_resources
}
