# Terragrunt EC2 Environment

This project provides a Terragrunt configuration for managing EC2 instances in both development and production environments. It utilizes a modular approach to define the EC2 resources, making it easy to manage and scale.

## Project Structure

```
terragrunt-ec2-env
├── envs
│   ├── dev
│   │   └── terragrunt.hcl      # Development environment configuration
│   └── prod
│       └── terragrunt.hcl      # Production environment configuration
├── modules
│   └── ec2
│       ├── main.tf              # Main Terraform configuration for EC2
│       ├── variables.tf         # Input variables for the EC2 module
│       └── outputs.tf           # Outputs for the EC2 module
└── README.md                    # Project documentation
```

## Getting Started

### Prerequisites

- Terraform installed on your machine.
- Terragrunt installed on your machine.
- AWS account with appropriate permissions to create EC2 instances.

### Setup

1. Clone the repository to your local machine.
2. Navigate to the desired environment directory (either `envs/dev` or `envs/prod`).
3. Configure your AWS credentials if not already set up.
4. Run the following command to initialize the Terragrunt configuration:

   ```
   terragrunt init
   ```

5. To apply the configuration and create the EC2 instances, run:

   ```
   terragrunt apply
   ```

### Module Reference

The EC2 module is referenced in the `terragrunt.hcl` files located in the `envs` directory. Each environment can have its own specific configurations and inputs.

### Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any enhancements or bug fixes.

### License

This project is licensed under the MIT License. See the LICENSE file for more details.