output "password" {
  value = aws_iam_user_login_profile.interviewee_profile.password
}

output "user_arn" {
  value = aws_iam_user.interviewee.arn
}
