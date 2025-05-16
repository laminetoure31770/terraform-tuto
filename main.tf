terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "docker" {
   host = "unix:///var/run/docker.sock"
}

provider "docker" {}

resource "docker_network" "bigagi_network" {
  name = "bigagi_network"
}

resource "docker_image" "bigagi_image" {
  name         = "${var.image_name}"
  build {
    context    = "${path.module}/docker"
    dockerfile = "${path.module}/docker/Dockerfile"
  }
}

resource "docker_container" "bigagi_container" {
  name  = var.container_name
  image = docker_image.bigagi_image.latest
  networks_advanced {
    name = docker_network.bigagi_network.name
  }
  mounts {
    target = "/app/src/data.ts"
    source = "${path.module}/files/data.ts"
    type   = "bind"
  }
  mounts {
    target = "/app/src/common/app.config.ts"
    source = "${path.module}/files/app.config.ts"
    type   = "bind"
  }
  env = [
    "APP_NAME=${var.app_name}"
  ]
  ports {
    internal = 3000
    external = 3000
  }
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = "grafana/grafana-oss"
  networks_advanced {
    name = docker_network.bigagi_network.name
  }
  ports {
    internal = 3000
    external = 3001
  }
}
