resource "aws_s3_bucket" "site" {
  bucket_prefix = var.name
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

resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "site" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = var.bucket_access_OAI
    }
  }
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.site.json
}

resource "aws_s3_object" "data" {
  for_each = { for f in local.file_with_type : "${f.file}.${f.mime}" => f }

  bucket       = aws_s3_bucket.site.bucket
  key          = each.value.file
  source       = "${var.src}/${each.value.file}"
  etag         = filemd5("${var.src}/${each.value.file}")
  content_type = each.value.mime
}

# resource "aws_s3_bucket" "www" {
#   bucket = "www.${aws_s3_bucket.site.id}"
# }

# resource "aws_s3_bucket_website_configuration" "www" {
#   bucket = aws_s3_bucket.www.id

#   redirect_all_requests_to {
#     host_name = aws_s3_bucket.site.website_endpoint
#     protocol = "http"
#   }
# }



# resource "aws_s3_bucket_policy" "site" {
#   bucket = aws_s3_bucket.site.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid       = "PublicReadGetObject"
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = "s3:GetObject"
#         Resource = [
#           aws_s3_bucket.site.arn,
#           "${aws_s3_bucket.site.arn}/*",
#         ]
#       },
#     ]
#   })
# }

# data "aws_iam_policy_document" "www" {
#   statement {
#     actions   = ["s3:GetObject"]
#     resources = ["${aws_s3_bucket.www.arn}/*"]

#     principals {
#       type        = "AWS"
#       identifiers = [var.cloudfront_S3_OAI.iam_arn]
#     }
#   }
# }

# resource "aws_s3_bucket_policy" "www" {
#   bucket = aws_s3_bucket.www.id
#   policy = data.aws_iam_policy_document.www.json
# }

