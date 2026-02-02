provider "aws" {
  region = "us-east-2"
}

resource "aws_ecr_repository" "repoGit" {
  name                 = "repoforgithub"
  image_tag_mutability = "IMMUTABLE" # Prevents overwriting tags

  image_scanning_configuration {
    scan_on_push = true # Automatically scans images for vulnerabilities
  }

  encryption_configuration {
    encryption_type = "AES256" # Default encryption
  }

  tags = {
    Environment = "production"
  }
}

output "repository_url" {
  value = aws_ecr_repository.repoGit.repository_url
}
