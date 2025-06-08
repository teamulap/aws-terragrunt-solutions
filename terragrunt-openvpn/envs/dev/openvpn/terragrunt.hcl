dependency "vpc" {
  config_path = "../vpc"
  skip_outputs = true
  mock_outputs = {
    vpc_id    = "vpc-12345678"
    subnet_ids = ["subnet-11111111", "subnet-22222222"]
  }
}
include "root"{
  path = find_in_parent_folders("root.hcl")
  expose = true
}
include "env" {
  path = find_in_parent_folders("env.hcl")
  expose = true
}
include "region" {
  path = find_in_parent_folders("region.hcl")
  expose = true
}
terraform {
  source = "D:/Users/JC/Documents/Personal/Weekend Projects/terraform-modules//modules/aws-ec2-openvpn"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region  = "${include.region.locals.region}"
  profile = "${include.region.locals.profile}"
}
EOF
}

generate "required_providers" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.3.0"
}
EOF
}

inputs = {
  name = "${include.region.locals.project}"
  instance_type = "t2.micro"  # Free-tier eligible instance type
  region      = "${include.region.locals.region}"    # Specify your desired AWS region
  key_name    = "${include.region.locals.project}-${include.env.locals.environment}" # Replace with your EC2 key pair name
  custom_tags = {
    Project     = "${include.region.locals.project}"
    Environment = "${include.env.locals.environment}"
    Contact     = "jcbagtas"
    Cost_Center = "OpenVPN"
  }
  vpc_id = dependency.vpc.outputs.vpc_id
  subnet_id = dependency.vpc.outputs.subnet_ids[0]  # Use the first public subnet
}

