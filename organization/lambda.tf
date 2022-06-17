data "aws_iam_role" "lambda" {
  name = var.authorized_role
}

resource "aws_lambda_function" "test" {

  filename      = "../resources/lambdacode.zip"
  function_name = "test_lambda"
  role          = data.aws_iam_role.lambda.arn
  handler       = "lambdacode.handler"
  source_code_hash = filebase64sha256("../resources/lambdacode.zip")

  runtime = "nodejs12.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_function_url" "test_latest" {
  function_name      = aws_lambda_function.test.function_name
  authorization_type = "NONE"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.aws_region}:${local.account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.test_GET.http_method}${aws_api_gateway_resource.test.path}"
}