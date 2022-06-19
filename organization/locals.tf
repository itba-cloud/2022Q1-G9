# ---------------------------------------------------------------------------
# Locals
# ---------------------------------------------------------------------------

locals {
    aws_account_id = data.aws_caller_identity.current.account_id

    #AWS VPC CONFIGURATION
    aws_vpc_cidr = "10.0.0.0/16"
    aws_vpc_az_count = 2

    # S3
    bucket_name = "pechi-itba-cloud-computing"
    static_resources        = "resources"
    s3 = {

    website = {
      bucket_name = local.bucket_name
      path        = "../resources"

      objects = {
        image1 = {
          filename     = "kiwi.jpeg"
          content_type = "image/jpeg"
        }
      }
    }

    www-website = {
      bucket_name = "www.${local.bucket_name}"
    }
  }
}