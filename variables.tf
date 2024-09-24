variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
}

variable "github_user" {
  description = "GitHub Username"
  type        = string
}

variable "key_expiration_days" {
  description = "Number of days until the SSH key expires"
  type        = number
  default     = 2
}

