# Dummy Terraform configuration for tfsec scanning

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-devsecops-demo-bucket"
  acl    = "public-read"  # tfsec will warn about public access
}
