variable "network_name" {}
variable "openai_api_key" {}
variable "log_dir" {}

resource "docker_image" "bigagi" {
  name = "bigagi"
  build {
    context    = "${path.module}"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "bigagi" {
  name  = "bigagi"
  image = docker_image.bigagi.name

  env = [
    "OPENAI_API_KEY=${var.openai_api_key}"
  ]

  networks_advanced {
    name = var.network_name
  }

  volumes {
    host_path      = "${var.log_dir}/bigagi.log"
    container_path = "/app/install.log"
  }

  ports {
    internal = 3000
    external = 3000
  }
}
