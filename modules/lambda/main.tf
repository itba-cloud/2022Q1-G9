data "aws_iam_role" "lambda" {
  name = var.aws_authorized_role
}

resource "aws_lambda_function" "this" {
  filename = var.filename

  function_name    = var.function_name
  role             = data.aws_iam_role.lambda.arn
  handler          = var.handler
  source_code_hash = filebase64sha256(var.filename)

  runtime = var.runtime

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.lambda.id]
  }

  tags = var.tags
}