# output "user_credentials" {
#   description = "ALL creds"
#   value = [
#     for i in range(length(var.username)) : {
#       username          = aws_iam_user.team[i].name
#       password          = aws_iam_user_login_profile.password-user[i].password
#       access_key_id     = aws_iam_access_key.access-key[i].id
#       secret_access_key = aws_iam_access_key.access-key[i].secret
#     }
#   ]
#   sensitive = true
# }
