# ---------------------------------------------------------------------------
# Variables
# ---------------------------------------------------------------------------
variable aws_authorized_role {
  description = "Authorized role for application operations"
  type        = string
}

variable aws_region {
  description = "AWS Region in which to deploy the application"
  type = string
}