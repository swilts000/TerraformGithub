# Terraform AWS ECR Repository

Terraform configuration to provision a hardened AWS Elastic Container Registry (ECR) repository for storing container images.

## Features

- **Immutable image tags** — prevents existing tags from being overwritten
- **Scan on push** — automatically scans images for vulnerabilities when pushed
- **AES-256 encryption** — server-side encryption of images at rest

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0
- AWS credentials configured (via environment variables, `~/.aws/credentials`, or an IAM role)
- Sufficient IAM permissions to create ECR repositories

## Usage

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Plan the deployment

```bash
terraform plan
```

### 3. Apply the configuration

```bash
terraform apply
```

### 4. Override the default repository name (optional)

```bash
terraform apply -var='ecr_name=my-custom-repo'
```

## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `ecr_name` | Name of the ECR repository | `string` | `repoforgithub` |

## Outputs

| Name | Description |
|------|-------------|
| `repository_url` | The URL of the created ECR repository |

## AWS Region

This configuration targets **`us-east-2`** (US East - Ohio). Update the `region` in the `provider "aws"` block or use the `AWS_DEFAULT_REGION` environment variable to change it.

## Destroying Resources

```bash
terraform destroy
```

> **Note:** Deleting an ECR repository will also delete all images stored within it.

## License

MIT
