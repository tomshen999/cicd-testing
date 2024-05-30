variable "tf_state_bucket" {
  description = "Name of S3 bucket in AWS for storing TF state"
  default     = "cicd-testing-s3-tf-state"
}

variable "tf_state_lock_table" {
  description = "Name of DynamoDB table for TF state locking"
  default     = "cicd-testing-dynamo-tf-lock"
}

variable "project" {
  description = "Project name for tagging resources"
  default     = "cicd-testing"
}

variable "contact" {
  description = "Contact name for tagging resources"
  default     = "cicd-testing@omni-tracking.com"
}
