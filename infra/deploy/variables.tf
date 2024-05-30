variable "prefix" {
  description = "Prefix for resources in AWS"
  default     = "cicd"
}

variable "project" {
  description = "Project name for tagging resources"
  default     = "cicd-testing"
}

variable "contact" {
  description = "Contact email for tagging resources"
  default     = "cicd-testing@omni-tracking.com"
}

variable "db_username" {
  description = "Username for database"
  default     = "ot_admin"
}

variable "db_password" {
  description = "Password for the Terraform database"
}

variable "ecr_proxy_image" {
  description = "Path to the ECR repo with the proxy image"
}

variable "ecr_api_sys_image" {
  description = "Path to the ECR repo with the ot-api-sys image"
}

variable "ecr_api_app_image" {
  description = "Path to the ECR repo with the ot-api-app image"
}

variable "ecr_report_image" {
  description = "Path to the ECR repo with the ot-report image"
}
