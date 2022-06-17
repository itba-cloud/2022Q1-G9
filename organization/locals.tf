# ---------------------------------------------------------------------------
# Locals
# ---------------------------------------------------------------------------

locals {
    account_id = data.aws_caller_identity.current.account_id

    # S3
    bucket_name = "pechi-itba-cloud-computing"
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
