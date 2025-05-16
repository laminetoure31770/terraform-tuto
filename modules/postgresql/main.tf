
resource "docker_image" "postgres" {
  name = "postgres:15"
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.postgres.latest
  restart = "always"

  env = [
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}"
  ]

  ports {
    internal = 5432
    external = 5432
  }

  volumes {
    host_path      = "${var.db_volume_host_path}"
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name = var.network_name
    aliases = ["postgres"]
  }
}
