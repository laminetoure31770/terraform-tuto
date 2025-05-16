
output "db_host" {
  value = "postgres"
}

output "db_port" {
  value = 5432
}

output "container_names" {
  value = [for c in docker_container.app : c.name]
}

output "container_ips" {
  value = { for c in docker_container.app : c.name => c.network_data[0].ip_address }
}
