output "cd_user_access_key_id" {
  description = "Access key ID for CD user"
  value       = aws_iam_access_key.cd.id
}

output "cd_user_access_key_secret" {
  description = "Access key secret for CD user"
  value       = aws_iam_access_key.cd.secret
  sensitive   = true
}

output "ecr_repo_api_sys" {
  description = "ECR repository URL for ot-api-sys image"
  value       = aws_ecr_repository.api-sys.repository_url
}

output "ecr_repo_api_app" {
  description = "ECR repository URL for ot-api-app image"
  value       = aws_ecr_repository.api-app.repository_url
}

output "ecr_repo_report" {
  description = "ECR repository URL for ot-report image"
  value       = aws_ecr_repository.report.repository_url
}

# output "ecr_repo_proxy" {
#   description = "ECR repository URL for the proxy image"
#   value       = aws_ecr_repository.proxy.repository_url
# }
