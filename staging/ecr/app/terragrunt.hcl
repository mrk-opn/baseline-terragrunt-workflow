terraform {
  source = "git::git@github.com:opn-ooo/opn-terraform-modules.git//aws/ecr?ref=v1.0.0"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "root" {
  config_path = "../../root"

  mock_outputs = {
    environment = "dummy"
  }
}

inputs = {
  name                    = "twallet-jp-apps"
  image_tag_mutability    = "MUTABLE"
  scan_on_push            = true
  create_lifecycle_policy = true
  lifecycle_policy = {
    "rules" : [
      {
        "rulePriority" : 1,
        "description" : "Keep up to 50 total  im ages",
        "selection" : {
          "tagStatus" : "any",
          "countType" : "imageCountMoreThan",
          "countNumber" : 50
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  }
  tags = {
    Environment = dependency.root.outputs.environment
  }
}
