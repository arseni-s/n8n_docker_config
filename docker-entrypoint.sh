#!/bin/sh
set -e

N8N_DIR="${N8N_USER_FOLDER:-/home/node/.n8n}"
NODES_DIR="$N8N_DIR/nodes"

echo "n8n user folder: $N8N_DIR"
echo "community nodes dir: $NODES_DIR"

mkdir -p "$NODES_DIR"
cd "$NODES_DIR"

# Ensure there's a package.json so pnpm has a project
if [ ! -f package.json ]; then
  echo "Creating package.json in $NODES_DIR"
  printf '{ "name": "n8n-community-nodes", "private": true }\n' > package.json
fi

# Install only if missing (keeps startup fast after first run)
if [ ! -d "node_modules/@searchapi/n8n-nodes-searchapi" ]; then
  echo "Installing @searchapi/n8n-nodes-searchapi with pnpm..."
  pnpm add @searchapi/n8n-nodes-searchapi
else
  echo "@searchapi/n8n-nodes-searchapi already installed, skipping."
fi

# Start n8n
exec n8n start
