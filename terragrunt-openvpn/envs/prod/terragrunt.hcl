include {
  path = "${find_in_parent_folders("terragrunt.hcl")}"
}

terraform {
  source = "../../modules/ec2"
}

inputs = {
  instance_type = "t2.micro"
  ami           = "ami-0c55b159cbfafe01e" # Replace with a valid AMI ID for production
  key_pair      = "your-key-pair-name"    # Replace with your key pair name
  security_group = "your-security-group-id" # Replace with your security group ID
}