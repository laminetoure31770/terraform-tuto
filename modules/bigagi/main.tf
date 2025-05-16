resource "docker_image" "bigagi" {
  name         = "bigagi-local"
  build {
    context    = dirname(var.dockerfile_path)
    dockerfile = basename(var.dockerfile_path)
  }
}

resource "docker_container" "bigagi" {
  name  = "bigagi-app"
  image = docker_image.bigagi.name

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = var.app_port
    external = var.app_port
  }

  env = [
    "DATABASE_HOST=${var.db_host}",
    "DATABASE_PORT=5432",
    "DATABASE_USER=${var.db_user}",
    "DATABASE_PASSWORD=${var.db_password}",
    "DATABASE_NAME=${var.db_name}"
  ]
}
