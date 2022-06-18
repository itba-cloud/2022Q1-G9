data "aws_iam_role" "lambda" {
  name = var.aws_authorized_role
}

resource "aws_lambda_function" "test" {

  filename      = "../resources/lambdacode.zip"
  function_name = "test_lambda"
  role          = data.aws_iam_role.lambda.arn
  handler       = "lambdacode.handler"
  source_code_hash = filebase64sha256("../resources/lambdacode.zip")

  runtime = "nodejs12.x"
}

resource "aws_lambda_function_url" "test_latest" {
  function_name      = aws_lambda_function.test.function_name
  authorization_type = "NONE"
}
