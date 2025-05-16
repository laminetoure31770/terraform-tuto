resource "docker_image" "postgres" {
  name = "postgres:latest"
}

resource "docker_container" "postgres" {
  name  = "bigagi-postgres"
  image = docker_image.postgres.id

  networks_advanced {
    name = var.network_name
  }

  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]

  ports {
    internal = 5432
    external = 5432
  }
}

output "container_name" {
  value = docker_container.postgres.name
}
