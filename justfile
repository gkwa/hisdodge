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
plan:
    terraform init
    terraform plan -out=tfplan -var="github_token=$GITHUB_TOKEN" -var="github_user=$GITHUB_USER"

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

# Run plan and apply in sequence
plan-apply:
    just plan
    just apply

