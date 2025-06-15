dependency "vpc" {
  config_path = "../vpc"
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
  source = "/workspaces/aws-terraform-modules/modules/aws-ec2-openvpn"
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
  # key_name    = "${include.region.locals.project}-${include.env.locals.environment}" # Replace with your EC2 key pair name
  custom_tags = {
    Project     = "${include.region.locals.project}"
    Environment = "${include.env.locals.environment}"
    Contact     = "team-ulap"
    Cost_Center = "home-vpn"
  }
  vpc_id = dependency.vpc.outputs.vpc_id
  subnet_id = dependency.vpc.outputs.subnet_ids[0]  # Use the first public subnet
  ingress_rules = [
    {
      from_port   = 1194
      to_port     = 1194
      protocol    = "udp"
      cidr_blocks = [include.env.locals.my_ipaddress]
    },
    {
      from_port   = 943
      to_port     = 943
      protocol    = "tcp"
      cidr_blocks = [include.env.locals.my_ipaddress]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [include.env.locals.my_ipaddress]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [include.env.locals.my_ipaddress]
    }
  ] 
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [include.env.locals.my_ipaddress]
    }
  ] 
}

