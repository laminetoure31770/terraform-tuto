
variable "db_name" {
  type    = string
  default = "bigagi"
}

variable "db_user" {
  type    = string
  default = "bigagi"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_volume_host_path" {
  type    = string
  default = "/var/lib/docker-volumes/bigagi-postgres"
}

variable "network_name" {
  type = string
}
