# Output variable definitions

output "domain_name" {
  description = "bucket domain name"
  value       = aws_s3_bucket.site.bucket_regional_domain_name
}