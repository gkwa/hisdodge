terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12.0"
    }
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm = "ED25519"
}

resource "time_rotating" "key_rotation" {
  rotation_days = var.key_expiration_days
}

locals {
  expiration_time = timeadd(time_rotating.key_rotation.rotation_rfc3339, "${var.key_expiration_days * 24}h")
}

resource "github_user_ssh_key" "deploy_key" {
  title = "Terraform-managed SSH key (Expires: ${local.expiration_time})"
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

output "key_expiration" {
  value = local.expiration_time
}

