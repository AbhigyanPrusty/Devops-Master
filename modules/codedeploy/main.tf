# CodeDeploy Application
resource "aws_codedeploy_app" "devops_app" {
  name = "DevOps2025App"
  compute_platform = "Server"
}

# CodeDeploy Deployment Group
resource "aws_codedeploy_deployment_group" "devops_group" {
  app_name              = aws_codedeploy_app.devops_app.name
  deployment_group_name = "DevOps2025Group"
  service_role_arn      = var.codedeploy_role_arn

  deployment_config_name = "CodeDeployDefault.OneAtATime"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "DevOps2025-Instance"
    }
  }
}
