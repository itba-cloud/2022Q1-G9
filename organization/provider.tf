# ---------------------------------------------------------------------------
# Provider
# ---------------------------------------------------------------------------

provider "aws" {
    alias  = "aws"
    region = var.aws_region
    
    shared_credentials_files = ["~/.aws/credentials"]
    profile                 = "default"
}