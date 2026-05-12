variable "ecr_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "repoforgithub"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_ecr_repository" "repoGit" {
  name                 = var.ecr_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Environment = "production"
  }
}

output "repository_url" {
  value = aws_ecr_repository.repoGit.repository_url
}