# Create IAM User
resource "aws_iam_user" "raj_user" {
  name = "raj_user"
}

# Create IAM Group
resource "aws_iam_group" "asale_group" {
  name = "asale_group"
}

# Add User to the Group
resource "aws_iam_user_group_membership" "asale_member" {
  user  = aws_iam_user.raj_user.name
  groups = [aws_iam_group.asale_group.name]
}

# Create IAM Policy
resource "aws_iam_policy" "iam_policy" {
  name = "iam_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

# Attach IAM Policy to the Group
resource "aws_iam_group_policy_attachment" "iam_policy_attachment" {
  group      = aws_iam_group.asale_group.name
  policy_arn = aws_iam_policy.iam_policy.arn
}
