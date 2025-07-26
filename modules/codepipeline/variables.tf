variable "pipeline_role_arn" {
  type = string
}

variable "codebuild_project_name" {
  type = string
}

variable "codedeploy_app_name" {
  type = string
}

variable "codedeploy_group_name" {
  type = string
}

variable "artifact_bucket_name" {
  type = string
  default = "abhigyan-2025" # or reference from your s3 module
}