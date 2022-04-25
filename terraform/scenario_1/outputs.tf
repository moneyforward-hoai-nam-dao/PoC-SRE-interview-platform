output "password" {
  value = aws_iam_user_login_profile.interviewee_profile.password
}

output "user_arn" {
  value = aws_iam_user.interviewee.arn
}

output "access_key" {
  value = aws_iam_access_key.sre_interviewee.id
}

// terraform output -raw secret 
output "secret" {
  value     = aws_iam_access_key.sre_interviewee.secret
  sensitive = true
}