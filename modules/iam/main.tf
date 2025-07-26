######################
# CODEPIPELINE ROLE
######################
resource "aws_iam_role" "codepipeline_role" {
  name = "CodePipelineRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = { Service = "codepipeline.amazonaws.com" },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Allow CodePipeline to use CodeStar connection
resource "aws_iam_role_policy" "allow_codestar_connection" {
  name = "AllowCodeStarConnection"
  role = aws_iam_role.codepipeline_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "codestar-connections:UseConnection"
        ],
        Resource = "arn:aws:codeconnections:ap-south-1:710783459512:connection/ace5dbe2-b79b-44cf-b008-3518d854fdbe"
      }
    ]
  })
}

# Allow CodePipeline to interact with S3, CodeBuild, and CodeDeploy
resource "aws_iam_role_policy" "codepipeline_permissions" {
  name = "CodePipelineExtraPermissions"
  role = aws_iam_role.codepipeline_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # S3 access for artifact bucket
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetBucketVersioning"
        ],
        Resource = [
          "arn:aws:s3:::abhigyan-2025",
          "arn:aws:s3:::abhigyan-2025/*"
        ]
      },
      # Start and monitor CodeBuild builds
      {
        Effect = "Allow",
        Action = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds"
        ],
        Resource = "arn:aws:codebuild:ap-south-1:710783459512:project/DevOps2025Build"
      },
      # CodeDeploy permissions
      {
        Effect = "Allow",
        Action = [
          "codedeploy:CreateDeployment",
          "codedeploy:GetApplication",
          "codedeploy:GetApplicationRevision",
          "codedeploy:GetDeployment",
          "codedeploy:GetDeploymentConfig",
          "codedeploy:RegisterApplicationRevision"
        ],
        Resource = "*"
      }
    ]
  })
}

######################
# CODEBUILD ROLE
######################
resource "aws_iam_role" "codebuild_role" {
  name = "CodeBuildRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = { Service = "codebuild.amazonaws.com" },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach AWS managed policy for CodeBuild basic permissions
resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

# CloudWatch logging permissions for CodeBuild
resource "aws_iam_role_policy" "codebuild_logging" {
  name = "CodeBuildLogging"
  role = aws_iam_role.codebuild_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

# S3 read/write for CodeBuild (download source and upload artifacts)
resource "aws_iam_role_policy" "codebuild_s3_access" {
  name = "CodeBuildS3Access"
  role = aws_iam_role.codebuild_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        Resource = [
          "arn:aws:s3:::abhigyan-2025",
          "arn:aws:s3:::abhigyan-2025/*"
        ]
      }
    ]
  })
}

######################
# CODEDEPLOY ROLE
######################
resource "aws_iam_role" "codedeploy_role" {
  name = "CodeDeployRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = { Service = "codedeploy.amazonaws.com" },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_policy" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}
