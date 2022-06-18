# ---------------------------------------------------------------------------
# Variables
# ---------------------------------------------------------------------------
variable base_domain {
  description = "Base domain for the application."
  type = string
}

variable aws_authorized_role {
  description = "Authorized role for all application operations"
  type        = string
}

variable aws_region {
  description = "AWS Region in which to deploy the application"
  type = string
}