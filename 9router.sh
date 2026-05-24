#!/bin/bash

# =========================================================
# 9Router Installer
# =========================================================
#
# This script will:
#   - Install Node.js 22
#   - Install 9Router globally
#   - Create systemd service
#   - Enable auto start on boot
#
# =========================================================

set -e

SERVICE_NAME="9router"

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

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

log "Checking Node.js..."

if ! command_exists node; then
    log "Node.js not found. Installing Node.js 22..."

    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
    sudo apt install -y nodejs

    success "Node.js installed ($(node -v))"
else
    success "Node.js already installed ($(node -v))"
fi

log "Installing 9Router..."

sudo npm install -g 9router

success "9Router installed"

log "Creating systemd service..."

sudo tee /etc/systemd/system/${SERVICE_NAME}.service > /dev/null <<EOF
[Unit]
Description=9Router Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/env 9router --no-browser --tray --log
Restart=always
RestartSec=5
User=root

[Install]
WantedBy=multi-user.target
EOF

success "Service created"

log "Reloading systemd..."

sudo systemctl daemon-reload

success "Systemd reloaded"

log "Enabling service..."

sudo systemctl enable ${SERVICE_NAME} > /dev/null 2>&1

success "Service enabled"

log "Starting 9Router service..."

sudo systemctl restart ${SERVICE_NAME}

sleep 3

if systemctl is-active --quiet ${SERVICE_NAME}; then
    success "9Router service started"
else
    error "Failed to start 9Router"
fi

echo ""
echo "=================================================="
echo " Installation Complete"
echo "=================================================="
echo ""

echo "9Router Information:"
echo ""
echo "  Dashboard : http://localhost:20128/dashboard"
echo "  API       : http://localhost:20128/v1"
echo ""

echo "Useful Commands:"
echo ""
echo "  View logs:"
echo "    journalctl -u ${SERVICE_NAME} -f"
echo ""
echo "  Restart service:"
echo "    sudo systemctl restart ${SERVICE_NAME}"
echo ""
echo "  Stop service:"
echo "    sudo systemctl stop ${SERVICE_NAME}"
echo ""
echo "  Service status:"
echo "    sudo systemctl status ${SERVICE_NAME}"
echo ""
