#!/bin/bash

# =========================================================
# Caddy Multi App Installer
# =========================================================
#
# Usage:
#   ./caddy.sh domain:port [domain:port ...]
#
# Example:
#   ./caddy.sh mirror.my.id:8080
#
# Multiple apps:
#   ./caddy.sh mirror.my.id:8080 api.my.id:3000
#
# =========================================================

set -e

if [ $# -eq 0 ]; then
    echo ""
    echo "Caddy Multi App Installer"
    echo ""
    echo "Usage:"
    echo "  $0 domain:port [domain:port ...]"
    echo ""
    echo "Examples:"
    echo "  $0 mirror.my.id:8080"
    echo "  $0 mirror.my.id:8080 api.my.id:3000"
    echo ""
    echo "Requirements:"
    echo "  - Domain must point to this server IP"
    echo "  - Application port must already be running"
    echo "  - User must have sudo privileges"
    echo ""
    exit 1
fi

log() {
    echo ""
    echo "[INFO] $1"
}

success() {
    echo "[OK] $1"
}

error() {
    echo "[ERROR] $1"
    exit 1
}

log "Installing dependencies..."

sudo apt update -y

sudo apt install -y \
    debian-keyring \
    debian-archive-keyring \
    apt-transport-https \
    curl \
    gnupg

success "Dependencies installed"

log "Configuring firewall (UFW)..."

sudo apt install -y ufw

sudo ufw allow 22/tcp comment 'SSH'
sudo ufw allow 80/tcp comment 'HTTP'
sudo ufw allow 443/tcp comment 'HTTPS'

echo "y" | sudo ufw enable

sudo ufw reload

success "Firewall configured (SSH, HTTP, HTTPS allowed)"

log "Adding Caddy repository..."

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | \
sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | \
sudo tee /etc/apt/sources.list.d/caddy-stable.list > /dev/null

success "Repository added"

log "Installing Caddy..."

sudo apt update -y
sudo apt install -y caddy

success "Caddy installed"

log "Generating Caddy configuration..."

CONFIG=""

for APP in "$@"
do
    DOMAIN=$(echo "$APP" | cut -d: -f1)
    PORT=$(echo "$APP" | cut -d: -f2)

    if [ -z "$DOMAIN" ] || [ -z "$PORT" ]; then
        error "Invalid format: $APP (expected domain:port)"
    fi

    echo "  - $DOMAIN -> localhost:$PORT"

    CONFIG="${CONFIG}
$DOMAIN {
    reverse_proxy localhost:$PORT
}

"
done

echo "$CONFIG" | sudo tee /etc/caddy/Caddyfile > /dev/null

success "Configuration generated"

log "Validating configuration..."

sudo caddy validate --config /etc/caddy/Caddyfile || \
error "Invalid Caddy configuration"

success "Configuration is valid"

log "Starting Caddy service..."

sudo systemctl enable caddy > /dev/null 2>&1
sudo systemctl restart caddy

success "Caddy service started"

echo ""
echo "=================================================="
echo " Installation Complete"
echo "=================================================="
echo ""

for APP in "$@"
do
    DOMAIN=$(echo "$APP" | cut -d: -f1)
    PORT=$(echo "$APP" | cut -d: -f2)

    printf "  %-30s -> localhost:%s\n" "https://$DOMAIN" "$PORT"
done

echo ""
echo "Useful Commands:"
echo ""
echo "  View logs:"
echo "    journalctl -u caddy -f"
echo ""
echo "  Restart Caddy:"
echo "    sudo systemctl restart caddy"
echo ""
echo "  Edit configuration:"
echo "    sudo nano /etc/caddy/Caddyfile"
echo ""
echo "  Validate configuration:"
echo "    sudo caddy validate --config /etc/caddy/Caddyfile"
echo ""
