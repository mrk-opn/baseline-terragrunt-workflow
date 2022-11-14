terraform {
  source = "git::https:///github.com:terraform-aws-modules/terraform-aws-ec2-instance//.?ref=v4.1.4"
}

include {
  path = find_in_parent_folders()
  merge_strategy = "deep"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  instance_count = 1
  instance_type  = "m3.medium"
  subnet_id = "subnet-eddcdzz4"
  vpc_security_group_ids = ["sg-112345678"]
}
