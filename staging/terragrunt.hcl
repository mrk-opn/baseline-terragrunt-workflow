remote_state {
  backend = "s3"
  config = {
    bucket         = "opn-staging-demo-test"
    key            = "${path_relative_to_include()}/demo-test.tfstate"
    region         = local.region
    encrypt        = true
    dynamodb_table = "demo-test-state-lock"
  }
}

locals {
  region      = "us-east-1"
  environment = "staging"
}

inputs = {
  region      = local.region
  environment = local.environment
}

generate "provider_versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    terraform {
      backend "s3" {}
      required_version = "~> 1.1" # Only update this whenever Terraform version in Atlantis changes
    }

    provider "aws" {
      region  = var.region
      shared_credentials_file = "~/.aws/config"
    }
  EOF
}
