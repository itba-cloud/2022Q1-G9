# ---------------------------------------------------------------------------
# Main resources
# ---------------------------------------------------------------------------

data "aws_region" "current" {
  provider = aws.aws
}

data "template_file" "userdata" {
  template = "../resources/html/index.html"
#   vars = {
#     ENDPOINT = "${aws_api_gateway_stage.this.invoke_url}"
#   }
}