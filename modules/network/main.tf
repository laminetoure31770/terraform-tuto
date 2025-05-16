variable "network_name" {}

resource "docker_network" "this" {
  name = var.network_name
}

output "network_name" {
  value = docker_network.this.name
}
