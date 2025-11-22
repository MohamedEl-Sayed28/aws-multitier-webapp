#!/bin/bash

# Memcached Setup Script for vProfile Application
# This script installs and configures Memcached on Amazon Linux 2

# Update system
sudo yum update -y

# Install Memcached
sudo yum install -y memcached

# Configure Memcached to listen on all interfaces
sudo sed -i 's/OPTIONS="-l 127.0.0.1"/OPTIONS="-l 0.0.0.0"/' /etc/sysconfig/memcached

# Start Memcached service
sudo systemctl start memcached
sudo systemctl enable memcached

# Verify service is running
sudo systemctl status memcached

echo "Memcached setup completed successfully!"
echo "Memcached is running on port 11211"
