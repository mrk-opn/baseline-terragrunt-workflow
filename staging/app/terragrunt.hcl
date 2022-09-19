terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-ec2-instance?ref=v4.1.4"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  instance_count = 1
  instance_type  = "m3.medium"
}
