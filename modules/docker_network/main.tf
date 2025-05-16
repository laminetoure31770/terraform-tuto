resource "docker_network" "agi_network" {
  name = "agi_network"
}

output "network_name" {
  value = docker_network.agi_network.name
}