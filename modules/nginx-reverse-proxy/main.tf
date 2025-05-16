resource "docker_container" "certbot" {
  name  = "certbot"
  image = "certbot/certbot"

  command = [
    "certonly",
    "--webroot",
    "--webroot-path=/var/www/certbot",
    "--email=admin@mondomaine.com",
    "--agree-tos",
    "--no-eff-email",
    "-d",
    "bigagi.mondomaine.com"
  ]

  volumes {
    host_path      = "/etc/letsencrypt"
    container_path = "/etc/letsencrypt"
  }

  volumes {
    host_path      = "/var/www/certbot"
    container_path = "/var/www/certbot"
  }

  depends_on = [docker_container.nginx]
}
