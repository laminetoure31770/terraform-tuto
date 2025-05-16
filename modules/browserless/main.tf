variable "network_name" {}
variable "log_dir" {}

resource "docker_container" "browserless" {
  name  = "browserless"
  image = "browserless/chrome"

  env = [
    "TOKEN=dummytoken"
  ]

  networks_advanced {
    name = var.network_name
  }

  volumes {
    host_path      = "${var.log_dir}/browserless.log"
    container_path = "/var/log/app.log"
  }

  ports {
    internal = 3001
    external = 3001
  }
}
