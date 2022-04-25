resource "aws_iam_user" "interviewee" {
  name = "sre-interviewee"

  tags = {
    team = "SRE"
    time = "04-2022"
  }
}

resource "aws_iam_policy" "power_access_policy" {
  name = "interviewee-policy"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "NotAction" : [
            "iam:*",
            "organizations:*",
            "account:*"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "iam:CreateServiceLinkedRole",
            "iam:DeleteServiceLinkedRole",
            "iam:ListRoles",
            "organizations:DescribeOrganization",
            "account:ListRegions"
          ],
          "Resource" : "*"
        }
      ]
    }
  )

}

resource "aws_iam_policy_attachment" "policy-attachment" {
  name       = "policy-attachment"
  users      = [aws_iam_user.interviewee.name]
  policy_arn = aws_iam_policy.power_access_policy.arn
}

resource "aws_iam_user_login_profile" "interviewee_profile" {
  user                    = aws_iam_user.interviewee.name
  password_reset_required = false
  password_length         = 32
}
