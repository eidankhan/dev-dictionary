#!/bin/bash
set -e

echo "🔴 Stopping all Docker containers..."
docker stop $(docker ps -aq) 2>/dev/null || true

echo "🗑️ Removing all Docker containers..."
docker rm $(docker ps -aq) 2>/dev/null || true

echo "🗑️ Removing all Docker images..."
docker rmi $(docker images -q) 2>/dev/null || true

echo "🗑️ Removing all Docker volumes..."
docker volume rm $(docker volume ls -q) 2>/dev/null || true

echo "🗑️ Removing all Docker networks..."
docker network rm $(docker network ls -q) 2>/dev/null || true

echo "🧹 Cleaning up unused Docker resources..."
docker system prune -af --volumes

echo "🛑 Stopping and removing Nginx..."
sudo systemctl stop nginx 2>/dev/null || true
sudo systemctl disable nginx 2>/dev/null || true
sudo apt-get remove --purge -y nginx nginx-common nginx-core || true
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "🗑️ Removing Nginx config and web root..."
sudo rm -rf /etc/nginx /var/www/*

echo "🔥 Flushing firewall rules..."
sudo ufw disable || true
sudo iptables -F || true
sudo iptables -X || true

echo "✅ VPS cleanup complete! Now clean your DNS records in domain registrar."
