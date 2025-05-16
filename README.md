
# Big-AGI Modular Terraform Infrastructure
Demo Terraform Big AGI

## 🚀 Services Déployés

- Big-AGI (https://github.com/enricoros/big-AGI)
- Auth.js Adapter (OAuth via Google, GitHub, Facebook, Email)
- Browserless (headless Chrome)
- Grafana (monitoring)
- Prometheus (metrics)
- Elasticsearch (logs)
- NGINX Reverse Proxy (avec HTTPS + page d’accueil personnalisée)

## 🔧 Déploiement

1. Installe Terraform et Docker
2. Remplis `terraform.tfvars` avec tes clés/ID
3. Lance :
```bash
terraform init
terraform apply
```

4. Accède à :
- `https://localhost/` → Accueil
- `https://localhost/app` → Big-AGI
- `https://localhost/grafana` → Grafana
- `https://localhost/prometheus` → Prometheus

## 🔐 Authentification

- Gérée par Auth.js Adapter containerisé
- Compatible OAuth + Email

# 🔐 HTTPS avec certificat autosigné

Pour la démo, HTTPS fonctionne avec un **certificat autosigné**. Les navigateurs afficheront un avertissement de sécurité que vous pouvez ignorer.

## 📜 Générer un certificat autosigné

Depuis le dossier `modules/nginx-reverse-proxy`, exécutez :

```bash
mkdir -p certs
openssl req -x509 -newkey rsa:4096 -keyout certs/selfsigned.key -out certs/selfsigned.crt -days 365 -nodes -subj "/CN=localhost"
```

## 📁 Structure des fichiers NGINX

```
modules/nginx-reverse-proxy/
├── certs/
│   ├── selfsigned.crt
│   └── selfsigned.key
├── html/
│   └── index.html
├── nginx.conf
├── Dockerfile
└── main.tf
```

## 🌐 Accès sécurisé

Après `terraform apply`, accédez à :

- `https://localhost/` → page d’accueil
- `https://localhost/app/` → interface Big-AGI

Vous devrez **accepter l’exception de sécurité** du navigateur pour continuer.

## 🔑 Passer en Let's Encrypt (optionnel)

Si vous disposez d’un domaine pointant vers votre machine :

1. Modifiez `nginx.conf` pour utiliser Certbot (voir exemple)
2. Montez `/etc/letsencrypt` dans NGINX
3. Utilisez l’image `certbot/certbot` pour générer un certificat réel


## 🛢️ Base de Données PostgreSQL

Un conteneur PostgreSQL est déployé pour Big-AGI :

- Port : `5432`
- DB : `bigagi`
- User : `bigagi`
- Password : (défini dans `terraform.tfvars`)

**Connexion interne :**

Big-AGI peut se connecter via l'alias `postgres:5432` sur le réseau Docker.
