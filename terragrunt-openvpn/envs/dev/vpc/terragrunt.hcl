terraform {
  source = "/workspaces/aws-terraform-modules//modules/aws-vpc"
}
include {
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
    name                         = "${include.region.locals.project}"
    region                       = "${include.region.locals.region}"
    vpc_cidr                     = "10.0.0.0/16"
    vpc_subnets                  = ["10.0.0.0/24", "10.0.1.0/24"]
    vpc_subnet_availability_zone = ["${include.region.locals.region}a", "${include.region.locals.region}c"]
    vpc_enable_dns_hostnames     = true
    custom_tags = {
      Project     = "${include.region.locals.project}"
      Environment = "${include.env.locals.environment}"
      Contact     = "team-ulap"
      Cost_Center = "home-vpn"
    }
    profile = "${include.region.locals.profile}"
    environment = "${include.env.locals.environment}"
    nacl_rules = {
      ingress = [
        {
          rule_no    = 100
          protocol   = "tcp"
          action     = "allow"
          cidr_block = include.env.locals.my_ipaddress
          from_port  = 1024
          to_port    = 65535
        }
      ]
      egress = [
        {
          rule_no    = 100
          protocol   = "tcp"
          action     = "allow"
          cidr_block = include.env.locals.my_ipaddress
          from_port  = 1024
          to_port    = 65535
        }
      ]
    }
}

