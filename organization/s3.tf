resource "aws_s3_bucket" "site" {
  bucket_prefix = "site"
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket" "www" {
  bucket = "www.${aws_s3_bucket.site.id}"
}

resource "aws_s3_bucket_website_configuration" "www" {
  bucket = aws_s3_bucket.www.id

  redirect_all_requests_to {
    host_name = aws_s3_bucket.site.id
  }
}

resource "aws_s3_object" "data" {
  for_each = {for f in local.file_with_type: "${f.file}.${f.mime}" => f}

  bucket = aws_s3_bucket.site.bucket
  key    = each.value.file
  source = "../resources/${each.value.file}"
  etag   = filemd5("../resources/${each.value.file}")
  content_type = each.value.mime
}

locals {
  filetypes = {
    "html": "text/html",
    "jpg":  "image/jpg",
    "jpeg": "image/jpeg",
    "png":  "image/png",
    "css":  "text/css",
    "js":   "application/javascript",
    "json": "application/json",
  }

  file_with_type = flatten([
    for type, mime in local.filetypes : [
      for k, v in fileset("../resources", "**/*.${type}"): {
        mime = mime
        file = v 
      }
    ]
  ])
}

output "domain_name" {
  description = "bucket domain name"
  value       = aws_s3_bucket.site.bucket_regional_domain_name
}

output "files" {
  description = "files"
  value       = fileset("../resources", "**/*")
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "www" {
  bucket = aws_s3_bucket.www.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
