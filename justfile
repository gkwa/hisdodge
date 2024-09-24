# List all available commands
default:
    @just --list

# Format all files
format: format-just format-tf

# Format Terraform files
format-tf:
    terraform fmt

# Format justfile
format-just:
    just --unstable --fmt

# Initialize and plan Terraform changes
plan days="2":
    terraform init
    terraform plan -out=tfplan -var="github_token=$GITHUB_TOKEN" -var="github_user=$GITHUB_USER" -var="key_expiration_days={{days}}"

# Apply Terraform changes
apply:
    terraform apply tfplan

# Destroy Terraform-managed infrastructure
destroy:
    terraform destroy -var="github_token=$GITHUB_TOKEN" -var="github_user=$GITHUB_USER"

# Initialize Terraform
init:
    terraform init

# Show Terraform plan
show:
    terraform show tfplan

# Clean up .terraform directory and other Terraform-generated files
cleanup:
    rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup tfplan id_ed25519 id_ed25519.pub

# DANGER: Destroy all resources without confirmation
destroy-no-confirm:
    terraform destroy -auto-approve -var="github_token=$GITHUB_TOKEN" -var="github_user=$GITHUB_USER"

# Run plan and apply in sequence with specified days
plan-apply days="2":
    just plan {{days}}
    just apply

# Create a new key with specified expiration days
create-key days="2":
    just plan-apply {{days}}

# Rotate the existing key with specified expiration days
rotate-key days="2":
    just destroy-no-confirm
    just create-key {{days}}
