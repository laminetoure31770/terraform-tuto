
variable "openai_api_key" {
  type        = string
  sensitive   = true
}

variable "nextauth_secret" {
  type        = string
  sensitive   = true
}

variable "github_id" {
  type = string
}

variable "github_secret" {
  type = string
  sensitive = true
}

variable "google_id" {
  type = string
}

variable "google_secret" {
  type = string
  sensitive = true
}

variable "facebook_id" {
  type = string
}

variable "facebook_secret" {
  type = string
  sensitive = true
}

variable "log_dir" {
  type    = string
  default = "/var/log/docker-apps"
}

variable "db_password" {
  type = string
  sensitive = true
}
