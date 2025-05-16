
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

module "network" {
  source = "./modules/docker_network"
}

module "bigagi" {
  source         = "./modules/bigagi"
  network_name   = module.network.network_name
  openai_api_key = var.openai_api_key
  log_dir        = var.log_dir
  nextauth_secret = var.nextauth_secret
  github_id     = var.github_id
  github_secret = var.github_secret
  google_id     = var.google_id
  google_secret = var.google_secret
  facebook_id   = var.facebook_id
  facebook_secret = var.facebook_secret
}

module "browserless" {
  source       = "./modules/browserless"
  network_name = module.network.network_name
  log_dir      = var.log_dir
}

module "grafana" {
  source       = "./modules/grafana"
  network_name = module.network.network_name
  log_dir      = var.log_dir
}

module "prometheus" {
  source       = "./modules/prometheus"
  network_name = module.network.network_name
  log_dir      = var.log_dir
}

module "elasticsearch" {
  source       = "./modules/elasticsearch"
  network_name = module.network.network_name
  log_dir      = var.log_dir
}

module "auth" {
  source       = "./modules/authjs-adapter"
  network_name = module.network.network_name
  log_dir      = var.log_dir
}

module "proxy" {
  source       = "./modules/nginx-reverse-proxy"
  network_name = module.network.network_name
}

module "postgresql" {
  source           = "./modules/postgresql"
  network_name     = module.network.network_name
  db_password      = var.db_password
}

module "local_deployment" {
  source = "./modules/local"
  count  = var.deploy_target == "local" ? 1 : 0
  # autres variables nécessaires
}

module "render_deployment" {
  source = "./modules/render"
  count  = var.deploy_target == "render" ? 1 : 0
  # autres variables nécessaires
}
