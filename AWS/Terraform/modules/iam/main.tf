resource "aws_iam_user" "test_user" {
  name = var.test_iam_user_name
}

resource "aws_iam_policy" "test_policy" {
  name        = "test-policy"
  description = "A test policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.test_user.name
  policy_arn = aws_iam_policy.test_policy.arn
}

resource "aws_iam_user_policy_attachment" "default-policy-attach" {
  user       = aws_iam_user.test_user.name
  policy_arn = var.default_policy_arn
}