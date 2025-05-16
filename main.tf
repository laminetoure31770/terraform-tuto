terraform {
  required_providers {
    docker = {
      source  = "registry.terraform.io/kreuzwerker/docker"
      version = "3.5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "docker" {
   host = "unix:///var/run/docker.sock"
}

module "network" {
  source = "./modules/network"
  network_name = "bigagi_network"
}

module "postgres" {
  source = "./modules/postgres"
  provider = docker
  network_name = module.network.network_name
  db_user     = var.db_user
  db_password = var.db_password
  db_name     = var.db_name
}

module "bigagi" {
  source = "./modules/bigagi"
  provider = docker
  network_name    = module.network.network_name
  db_user         = var.db_user
  db_password     = var.db_password
  db_name         = var.db_name
  db_host         = module.postgres.container_name
  app_port        = 3000
  dockerfile_path = "${path.module}/Dockerfile"
}
