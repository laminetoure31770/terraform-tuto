### 📄 `README.md`

```markdown
# 🚀 Tuto Terraform Local Big-AGI + Grafana

Ce projet Terraform déploie automatiquement :

- Un conteneur personnalisé à partir du projet [big-AGI](https://github.com/enricoros/big-AGI)
- Un conteneur Grafana pour l'observation
- Un réseau Docker dédié pour interconnecter les services

## 📁 Structure du projet

terraform-big-agi/
├── main.tf              # Déploiement des conteneurs
├── variables.tf         # Définition des variables
├── terraform.tfvars     # Valeurs par défaut
├── outputs.tf           # Résumé des IPs et ports
├── files/               # Fichiers personnalisés pour l'agent
│   ├── app.config.ts
│   └── data.ts
├── docker/
│   └── Dockerfile       # Dockerfile de Big-AGI (copié depuis GitHub)

````

## ✅ Prérequis

- [Docker](https://www.docker.com/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- Accès à internet pour cloner les fichiers ou copier le Dockerfile depuis GitHub

## ⚙️ Installation

```bash
terraform init
terraform apply
````

Les variables par défaut peuvent être modifiées dans `terraform.tfvars` :

```hcl
image_name     = "bigagi-custom"
container_name = "terraforme-agent"
app_name       = "Terraforme Agent"
network_name   = "bigagi_network"  # Nom du réseau Docker
```

## 🛠️ Personnalisation de l'agent

Modifie les fichiers dans `files/` :

* `app.config.ts` : configuration générale de l'application
* `data.ts` : nom de l'agent, objectifs, etc.

Ces fichiers sont montés automatiquement dans le conteneur.

## 🔗 Accès aux services

| Service     | URL                                            |
| ----------- | ---------------------------------------------- |
| Big-AGI App | [http://localhost:3000](http://localhost:3000) |
| Grafana     | [http://localhost:3001](http://localhost:3001) |

⚠️ Le port de Grafana est **3001** pour éviter les conflits avec Big-AGI.

## 🧩 Gestion du réseau Docker existant

Par défaut, le réseau `bigagi_network` est créé.
Si ce réseau **existe déjà**, Terraform échouera.

### ✅ Solution recommandée

Dans `terraform.tfvars`, spécifie le nom d’un réseau Docker existant :

```hcl
network_name = "ton_reseau_existants"
```

### 🧼 Ou supprime le réseau existant manuellement :

```bash
docker network rm bigagi_network
```
## 📤 Résultat de `terraform apply`

```bash
bigagi_container_name = "terraforme-agent"
bigagi_container_ip   = "172.18.0.2"
bigagi_app_port       = 3000

grafana_container_name = "grafana"
grafana_container_ip   = "172.18.0.3"
grafana_port           = 3001
```

## 🧹 Nettoyage

Pour supprimer tout :

```bash
terraform destroy
```

## ✨ À venir (optionnel)

* Dashboard Grafana préconfiguré
* Export de métriques via Prometheus
* Authentification Big-AGI avec proxy inverse

## 📄 Licence

Basé sur [Big-AGI (MIT)](https://github.com/enricoros/big-AGI/blob/main/LICENSE)
Infrastructure : libre utilisation sous [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0)
