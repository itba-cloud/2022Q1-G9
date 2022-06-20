output "files" {
  description = "The bucket files"
  value       = fileset("${var.src}", "**/*")
}

output "domain_name" {
  description = "The S3 bucket domain name"
  value       = aws_s3_bucket.site.bucket_regional_domain_name
}

output "id" {
  description = "The S3 bucket domain name"
  value       = aws_s3_bucket.site.id
}


