############################################################
# main.tf
#
# Creates an AWS ECR repository for storing container images.
# The file defines a configurable repository name, the AWS
# provider region, the ECR resource with common hardening
# options (immutable tags, scanning on push, AES256 encryption),
# and an output that exposes the repository URL for other modules
# or CI/CD systems to consume.
############################################################

# Name of the ECR repository. Can be overridden via CLI or
# environment (e.g. `-var='ecr_name=custom-name'`).
variable "ecr_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "repoforgithub"
}

# AWS provider configuration. Adjust `region` as needed for
# your deployment target or set it via provider configuration
# in a separate file or through environment variables.
provider "aws" {
  region = "us-east-2"
}

# ECR repository resource. Key settings:
# - `image_tag_mutability = "IMMUTABLE"` prevents tag overwrite.
# - `image_scanning_configuration.scan_on_push = true` enables
#   vulnerability scanning when images are pushed.
# - `encryption_configuration.encryption_type = "AES256"` ensures
#   server-side encryption of images at rest.
resource "aws_ecr_repository" "repoGit" {
  name                 = var.ecr_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}

# Output the repository URL so other modules or CI pipelines
# can reference it (for example, to push images or configure
# deployment manifests).
output "repository_url" {
  value = aws_ecr_repository.repoGit.repository_url
}
