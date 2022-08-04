variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}


variable "project_name" {
  description = "This is a project to deploy a drupal enviorment into AWS"
  type        = string
}
