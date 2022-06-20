# ---------------------------------------------------------------------------
# Versions
# ---------------------------------------------------------------------------

terraform {
    required_version = ">= 1.0.6"
  
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 4.10.0"
        }

        random = {
            source = "hashicorp/random"
            version = "~> 3.3.1"
        }
    }
}