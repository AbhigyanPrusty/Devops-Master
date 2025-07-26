terraform {
  backend "s3" {
    bucket         = "abhigyan-2025"
    key            = "codepipeline/terraform.tfstate"
    region         = "ap-south-1"
  }
}
