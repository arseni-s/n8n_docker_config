FROM n8nio/n8n:latest
USER root

# Install the community node package into the image
RUN npm install -g @searchapi/n8n-nodes-searchapi

# Keep n8n using your volume folder
ENV N8N_USER_FOLDER=/home/node/.n8n \
    N8N_REINSTALL_MISSING_PACKAGES=true

# pnpm is needed because @searchapi/n8n-nodes-searchapi enforces pnpm-only installs
RUN npm i -g pnpm

# Add startup script that installs the package into the persistent folder (only once)
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
