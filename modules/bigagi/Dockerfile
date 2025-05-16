FROM node:25

# Outils utiles
RUN apt-get update && apt-get install -y git curl

# Clone du repo
RUN git clone https://github.com/enricoros/big-AGI.git /app

WORKDIR /app

# Checkout de la branche v2-dev
RUN git checkout v2-dev

# Dépendances
RUN npm install

# Ajout d’un script de log
COPY scripts/install-log.sh /app/install-log.sh
RUN chmod +x /app/install-log.sh

# Lancer le script d’installation + l’application
CMD ["/app/install-log.sh"]

