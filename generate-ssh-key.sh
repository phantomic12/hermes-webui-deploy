#!/bin/bash
# Auto-generate SSH key pair for hermes-agent -> dev-container access
# Run this before docker compose up if ssh_key is missing

KEY_DIR="$(cd "$(dirname "$0")" && pwd)"
KEY="$KEY_DIR/ssh_key"
KEY_PUB="$KEY_DIR/ssh_key.pub"

if [ ! -f "$KEY" ]; then
    echo "Generating SSH key pair..."
    ssh-keygen -t ed25519 -f "$KEY" -N '' -o
    chmod 600 "$KEY"
    chmod 644 "$KEY_PUB"
    echo "Generated $KEY"
else
    echo "SSH key already exists at $KEY"
fi

# Verify keys match
echo "Public key:"
ssh-keygen -yf "$KEY"