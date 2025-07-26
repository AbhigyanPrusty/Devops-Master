module "iam_roles" {
  source = "./modules/iam"
}

module "codebuild" {
  source             = "./modules/codebuild"
  codebuild_role_arn = module.iam_roles.codebuild_role_arn
}

module "codedeploy" {
  source              = "./modules/codedeploy"
  codedeploy_role_arn = module.iam_roles.codedeploy_role_arn
}

module "codepipeline" {
  source = "./modules/codepipeline"

  pipeline_role_arn       = module.iam_roles.codepipeline_role_arn
  codebuild_project_name  = module.codebuild.devops_build_name
  codedeploy_app_name     = module.codedeploy.codedeploy_app_name
  codedeploy_group_name   = "DevOps2025Group"
}
