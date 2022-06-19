# ---------------------------------------------------------------------------
# Locals
# ---------------------------------------------------------------------------

locals {
    aws_account_id = data.aws_caller_identity.current.account_id

    #AWS VPC CONFIGURATION
    aws_vpc_cidr = "10.0.0.0/16"
    aws_vpc_az_count = 2

    # S3
    bucket_source = "../resources/s3"
    bucket_name = "cloud-site"

    # LAMBDA
    lambda_source = "../resources/lambda"
    lambda_name = "test_lambda"
    lambda_handler = "lambdacode.handler"
    lambda_runtime = "nodejs12.x"

}