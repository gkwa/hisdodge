# GitHub SSH Key Management with Terraform
This project uses Terraform to manage SSH keys for GitHub accounts.

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
# Plan changes
just plan
# Apply changes
just apply
# Plan and apply in one step
just plan-apply
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