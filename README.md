# GitHub SSH Key Management with Terraform

## Motivation
This project was created to address the need for quick iteration with temporary SSH keys during development. It provides a convenient way to generate and discard SSH keys, streamlining the process of managing access for short-term development tasks or temporary collaborations.

## Overview
This project uses Terraform to manage SSH keys for GitHub accounts. It automates the creation, deployment, and expiration of SSH keys, allowing developers to easily set up temporary access without the hassle of manual key management.

## Prerequisites
- Terraform installed
- Just command runner installed
- GitHub account with a Personal Access Token

## Setup
Set the following environment variables:
```bash
export GITHUB_TOKEN=your_github_token
export GITHUB_USER=your_github_username
```

## Usage
Here's a quick cheatsheet for common operations:
```bash
# Initialize Terraform
just init

# Plan changes (default 2 days expiration)
just plan

# Plan changes with custom expiration (e.g., 5 days)
just plan 5

# Apply changes
just apply

# Plan and apply in one step (default 2 days expiration)
just plan-apply

# Plan and apply with custom expiration (e.g., 7 days)
just plan-apply 7

# Create a new key (default 2 days expiration)
just create-key

# Create a new key with custom expiration (e.g., 3 days)
just create-key 3

# Rotate the existing key (default 2 days expiration)
just rotate-key

# Rotate the existing key with custom expiration (e.g., 4 days)
just rotate-key 4

# Destroy resources
just destroy

# Destroy resources without confirmation (use with caution!)
just destroy-no-confirm

# Clean up Terraform files and generated SSH keys
just cleanup

# Format Terraform files and justfile
just format

# Show current plan
just show
```

## Generated Files
After applying the Terraform configuration, two files will be created in the project directory:
- `id_ed25519`: The private SSH key (permission: 0600)
- `id_ed25519.pub`: The public SSH key (permission: 0644)

**Note:** These files are automatically added to `.gitignore` to prevent accidental commits.

## Security Notes
- The SSH keys are stored as local files and not in the Terraform state.
- Ensure that the `id_ed25519` (private key) file is kept secure and not shared.
- The `destroy-no-confirm` command bypasses safety checks. Use with extreme caution.
- By default, keys expire after 2 days. This can be adjusted when running the commands.

## Dependencies
- [Terraform](https://www.terraform.io/)
- [Just](https://github.com/casey/just)

## Customization
You can adjust the key expiration period by specifying the number of days when running the commands. If not specified, the default is set to 2 days.
