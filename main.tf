terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Réseau Docker dédié
resource "docker_network" "bigagi_net" {
  name = "bigagi_network"
}

# Conteneur PostgreSQL
resource "docker_image" "postgres" {
  name = "postgres:14"
  keep_locally = false
}

resource "docker_container" "postgres" {
  name  = "bigagi-postgres"
  image = docker_image.postgres.latest
  networks_advanced {
    name = docker_network.bigagi_net.name
  }

  env = [
    "POSTGRES_USER=bigagi",
    "POSTGRES_PASSWORD=supersecret",
    "POSTGRES_DB=bigagidb"
  ]

  ports {
    internal = 5432
    external = 5432
  }
}

# Conteneur big-AGI depuis l'image officielle
resource "docker_image" "bigagi" {
  name = "ghcr.io/enricoros/big-agi:latest"
}

resource "docker_container" "bigagi" {
  name  = "bigagi-app"
  image = docker_image.bigagi.latest
  networks_advanced {
    name = docker_network.bigagi_net.name
  }

  ports {
    internal = 3000
    external = 3000
  }

  # Exemple d'env pour se connecter à PostgreSQL (si big-AGI les utilise)
  env = [
    "DATABASE_HOST=bigagi-postgres",
    "DATABASE_PORT=5432",
    "DATABASE_USER=bigagi",
    "DATABASE_PASSWORD=supersecret",
    "DATABASE_NAME=bigagidb"
  ]

  depends_on = [docker_container.postgres]
}
