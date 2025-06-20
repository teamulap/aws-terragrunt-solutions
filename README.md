# Terragrunt Solutions

**Welcome!**

This is our Mono-repo of the AWS Solutions.

This terragrunt repo utilizes the terraform modules.

## Where are the modules

You may see a sample solution repo in our [AWS Terragrunt Solutions](https://github.com/teamulap/aws-terragrunt-modules.git)

### Know More about Dev Containers

- [Overview](https://containers.dev)
- [Our Setup](./DEVCONTAINER_TUTORIAL.md)

### Applying a solution

Make sure you setup the `hcl` files properly and always review the plan before applying!

1. Open the unit. ie `terragrunt-openvpn/envs/dev`
1. Prepare the remote-backend and vpc
   - Make sure that all of the details in your `hcl` files are correct before your un these in order:

```shell
cd terragrunt-openvpn/envs/dev/remote-backend
terragrunt init
terragrunt plan
terragrunt apply
```

```shell
cd terragrunt-openvpn/envs/dev/vpc
terragrunt init
terragrunt plan
terragrunt apply
```

1. Run the actual solution module

```shell
cd terragrunt-openvpn/envs/dev/openvpn
terragrunt init
terragrunt plan
terragrunt apply
```
