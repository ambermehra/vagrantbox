# Amazon Linux 2 Vagrant Box with Chef

This repository contains Packer templates and Chef cookbooks to build an  Vagrant box on base "bento/amazonlinux-2" on top of base box installed AWS SSM Plugin, CloudWatch Agent, and PostgreSQL.

## Prerequisites

- VirtualBox (latest version recommended)
- Vagrant (latest version recommended)
- Packer (>= 1.9.4)
- Git

## Directory Structure

```
.
├── .github
│   └── workflows
│       └── build-vagrant-box.yml    # GitHub Actions workflow for automated builds
├── cookbooks
│   ├── aws_ssm_plugin              # Cookbook for AWS SSM Plugin installation
│   │   ├── recipes
│   │   │   └── default.rb
│   │   └── attributes
│   │       └── default.rb
│   ├── cloudwatch_agent            # Cookbook for CloudWatch Agent setup
│   │   ├── recipes
│   │   │   └── default.rb
│   │   └── attributes
│   │       └── default.rb
│   └── postgres_db                 # Cookbook for PostgreSQL installation
│       ├── recipes
│       │   └── default.rb
│       └── attributes
│           └── default.rb
├── packer-vagrant-al2bx.pkr.hcl    # Packer template for building the box
└── README.md                       # This file
```

### Key Files Description

- `packer-vagrant-al2bx.pkr.hcl`: Main Packer template that defines how to build the Vagrant box. It uses the `bento/amazonlinux-2` base box and applies Chef cookbooks.

- `.github/workflows/build-vagrant-box.yml`: GitHub Actions workflow that automates the box building process and uploads it as an artifact.

- `cookbooks/aws_ssm_plugin/`:
  - `recipes/default.rb`: Installation steps for AWS SSM Pluging

- `cookbooks/cloudwatch_agent/`:
  - `recipes/default.rb`: Installation and configuration of CloudWatch Agent

- `cookbooks/postgres_db/`:
  - `recipes/default.rb`: PostgreSQL installation and setup

## How to Use This Repository

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
   ```

2. Build the box locally:
   ```bash
   packer init packer-vagrant-al2bx.pkr.hcl
   packer build packer-vagrant-al2bx.pkr.hcl
   ```

   Alternatively, you can download the pre-built box from the GitHub Actions artifacts:
   - Go to the Actions tab in the repository
   - Click on the latest successful workflow run
   - Download the "vagrant-box" artifact

## How to Add the Box

1. If you built the box locally or downloaded from GitHub Actions:
   ```bash
   vagrant box add my-al2-chef amazonlnux-2box/al2chef.box
   ```

2. Verify the box was added:
   ```bash
   vagrant box list
   ```

## How to Run the Box

1. Create a new directory for your Vagrant environment:
   ```bash
   mkdir my-al2-env
   cd my-al2-env
   ```

2. Initialize a new Vagrantfile:
   ```bash
   vagrant init my-al2-chef
   ```

3. Start the virtual machine:
   ```bash
   vagrant up
   ```

4. SSH into the machine:
   ```bash
   vagrant ssh
   ```

5. Common Vagrant commands:
   ```bash
   vagrant halt    # Stop the VM
   vagrant reload  # Restart the VM
   vagrant destroy # Remove the VM
   ```

## Pre-installed Components

This box comes with:
- AWS SSM Plugin
- CloudWatch Agent
- PostgreSQL

## Development

To modify the box:
1. Update the Chef cookbooks in the `cookbooks/` directory
2. Modify the Packer template (`packer-vagrant-al2bx.pkr.hcl`) if needed
3. Rebuild the box using Packer
4. The GitHub Actions workflow will automatically build the box when changes are pushed to the main branch

## Troubleshooting

If you encounter issues:
1. Ensure VirtualBox is properly installed and running
2. Check that virtualization is enabled in your BIOS
3. Verify Vagrant version compatibility with VirtualBox
4. For networking issues, try `vagrant reload`
