#!/bin/bash
set -eux

# Update packages
yum update -y

# Install nginx
amazon-linux-extras install -y nginx1

# Enable and start nginx
systemctl enable nginx
systemctl start nginx

# Simple health page
echo "Hello from private EC2 behind ALB" > /usr/share/nginx/html/index.html
