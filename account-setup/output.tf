output "iam_user_credentials" {
  description = "all creds of our users"
  value       = module.iam.user_credentials
  sensitive   = true
}
