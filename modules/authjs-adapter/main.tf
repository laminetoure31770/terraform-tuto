variable "network_name" {}
variable "log_dir" {}

resource "docker_container" "auth_adapter" {
  name  = "authjs-adapter"
  image = "ghcr.io/nextauthjs/adapter-example"

  env = [
    "PORT=3002"
  ]

  ports {
    internal = 3002
    external = 3002
  }

  networks_advanced {
    name = var.network_name
  }

  volumes {
    host_path      = "${var.log_dir}/authjs.log"
    container_path = "/var/log/app.log"
  }
}
