include "env" {
    path = find_in_parent_folders("env.hcl")
    expose = true
}
include "region" {
    path = find_in_parent_folders("region.hcl")
    expose = true
}

terraform {
    source = "/workspaces/aws-terraform-modules//modules/remote-backend"
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

inputs = {
    project                = "${include.region.locals.project}"
    environment            = "${include.env.locals.environment}"
    backend_bucket_name    = "${include.region.locals.project}"
    region                 = "${include.region.locals.region}"
    custom_tags = {
        Project     = "${include.region.locals.project}"
        Environment = "${include.env.locals.environment}"
        Contact     = "team-ulap"
        Cost_Center = "home-vpn"
    }
}
