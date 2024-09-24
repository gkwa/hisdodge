terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm = "ED25519"
}

resource "github_user_ssh_key" "deploy_key" {
  title = "Terraform-managed SSH key"
  key   = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_openssh
  filename        = "id_ed25519"
  file_permission = "0600"
}

resource "local_file" "public_key" {
  content         = tls_private_key.ssh_key.public_key_openssh
  filename        = "id_ed25519.pub"
  file_permission = "0644"
}

output "public_key_file" {
  value = local_file.public_key.filename
}

output "private_key_file" {
  value = local_file.private_key.filename
}

