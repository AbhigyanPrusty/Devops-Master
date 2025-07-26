
module "iam_roles" {
  source = "./modules/iam"
}

module "codedeploy" {
  source              = "./modules/codedeploy"
  codedeploy_role_arn = module.iam_roles.codedeploy_role_arn
}

module "codepipeline" {
  source = "./modules/codepipeline"

  pipeline_role_arn       = module.iam_roles.codepipeline_role_arn
  codebuild_project_name  = module.codebuild.project_name
  codedeploy_app_name     = module.codedeploy.codedeploy_app_name
  codedeploy_group_name   = "DevOps2025Group" # must match codedeploy module

  github_owner       = "AbhigyanPrusty"
  github_repo        = "Devops-Master"
  github_branch      = "main"
  github_oauth_token = ""
}

module "codebuild" {
  source            = "./modules/codebuild"
  codebuild_role_arn = module.iam_roles.codebuild_role_arn
}

