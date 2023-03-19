provider "aws" {
  access_key = ""
  secret_key = ""
  region     = var.lambda_region
}

# create IAM role
resource "aws_iam_role" "lambda_role" {
name   = "Udacity_Lambda_Function_Role"
assume_role_policy = <<EOF
{
    "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
    ]
  }
EOF
}

# create IAM policy 
resource "aws_iam_policy" "iam_policy_for_lambda" {
 
 name         = "aws_iam_policy_for_terraform_aws_lambda_role"
 path         = "/"
 description  = "AWS IAM Policy for managing aws lambda role"
 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

# Attach IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

# create data zip file which contains lamda function cHHOGewdmBqN21ZUbiazw
data "archive_file" "zip_the_python_code" {
type        = "zip"
source_dir  = "${path.module}/python/"
output_path = "${path.module}/python/greet_lambda.py.zip"
}

# create lambda function
resource "aws_lambda_function" "terraform_lambda_func" {
filename                       = "${path.module}/python/greet_lambda.py.zip"
function_name                  = "Udacity_Lambda_Function"
role                           = aws_iam_role.lambda_role.arn
handler                        = "greet_lambda.lambda_handler"
runtime                        = "python3.9"
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
environment {
    variables = {
      greeting = var.greeting
    }
  }
}