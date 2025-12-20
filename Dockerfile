FROM n8nio/n8n:latest
USER root

# Install the community node package into the image
RUN npm install -g @searchapi/n8n-nodes-searchapi

# Keep n8n using your volume folder
ENV N8N_USER_FOLDER=/home/node/.n8n \
    N8N_REINSTALL_MISSING_PACKAGES=true
