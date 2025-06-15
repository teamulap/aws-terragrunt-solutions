# Use Amazon Linux 2023 as the base image (it comes with glibc ≥ 2.28)
FROM amazonlinux:2023

# Set noninteractive mode for DNF operations
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install prerequisites with DNF
RUN dnf update -y && \
    dnf install -y \
        tar \
        gzip \
        git \
        wget \
        dnf-plugins-core \
        openssh-clients \
        unzip && \
    dnf clean all
# ---------------------------
# Install AWS CLI v2
# Download and install AWS CLI v2 using the official installer.
RUN wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip && \
    echo "AWS CLI version:" && aws --version
    
# ---------------------------
# Install Terraform
# Add HashiCorp’s repository for Amazon Linux 2023 and install Terraform.
RUN dnf config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo && \
    dnf install -y terraform && \
    echo "Terraform version:" && terraform version

# ---------------------------
# Install Terragrunt (latest v0.81.5)
ENV TERRAGRUNT_VERSION=0.81.5
RUN wget --quiet "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64" -O /usr/local/bin/terragrunt && \
    chmod +x /usr/local/bin/terragrunt && \
    echo "Terragrunt version:" && terragrunt --version
