output "bigagi_container_name" {
  description = "Nom du conteneur BigAGI"
  value       = docker_container.bigagi_container.name
}

output "bigagi_container_ip" {
  description = "Adresse IP du conteneur BigAGI"
  value       = docker_container.bigagi_container.network_data[0].ip_address
}

output "bigagi_app_port" {
  description = "Port de l'application BigAGI accessible depuis l'hôte"
  value       = docker_container.bigagi_container.ports[0].external
}

output "grafana_container_name" {
  description = "Nom du conteneur Grafana"
  value       = docker_container.grafana.name
}

output "grafana_container_ip" {
  description = "Adresse IP du conteneur Grafana"
  value       = docker_container.grafana.network_data[0].ip_address
}

output "grafana_port" {
  description = "Port Grafana accessible depuis l'hôte"
  value       = docker_container.grafana.ports[0].external
}
