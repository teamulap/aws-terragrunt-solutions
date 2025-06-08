locals {
    region = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}
remote_state {
    backend = "s3"
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
    config = {
        bucket       = "${local.region.locals.project}"
        key          = "${path_relative_to_include()}/terraform.tfstate"
        region       = "${local.region.locals.region}"
        encrypt      = true
        use_lockfile = true
        profile = "${local.region.locals.profile}"
    }
}