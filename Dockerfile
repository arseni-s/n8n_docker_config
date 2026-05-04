FROM docker.n8n.io/n8nio/n8n:2.18.5

USER root

# Ensure n8n uses your mounted volume folder
ENV N8N_USER_FOLDER=/home/node/.n8n \
    N8N_REINSTALL_MISSING_PACKAGES=true

# Add entrypoint that installs the node into the persistent volume folder
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

