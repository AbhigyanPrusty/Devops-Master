stage {
  name = "Source"

  action {
    name             = "Source"
    category         = "Source"
    owner            = "AWS"
    provider         = "CodeStarSourceConnection"
    version          = "1"
    output_artifacts = ["source_output"]

    configuration = {
      ConnectionArn    = "arn:aws:codeconnections:ap-south-1:710783459512:connection/ace5dbe2-b79b-44cf-b008-3518d854fdbe"
      FullRepositoryId = "AbhigyanPrusty/Devops-Master"
      BranchName       = "main"
    }
  }
}
