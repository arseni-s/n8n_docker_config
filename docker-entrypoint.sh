#!/bin/sh
set -e

N8N_DIR="${N8N_USER_FOLDER:-/home/node/.n8n}"
NODES_DIR="$N8N_DIR/nodes"

echo "Using N8N_USER_FOLDER=$N8N_DIR"
mkdir -p "$NODES_DIR"

cd "$NODES_DIR"

# Create a minimal package.json once so pnpm treats this as a project
if [ ! -f package.json ]; then
  echo '{ "name": "n8n-community-nodes", "private": true }' > package.json
fi

# Install only if missing (so redeploys are fast)
if [ ! -d "node_modules/@searchapi/n8n-nodes-searchapi" ]; then
  echo "Installing @searchapi/n8n-nodes-searchapi with pnpm..."
  pnpm add @searchapi/n8n-nodes-searchapi
else
  echo "@searchapi/n8n-nodes-searchapi already installed."
fi

# Start n8n
exec n8n start
