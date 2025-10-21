output "iam_user_credentials" {
  description = "all creds of our users"
  value       = module.iam.user_credentials
  sensitive   = true
}
# uncomment this when you need to see the output
# were commented out to avoid leaking sensitive data