#!/bin/bash

# MySQL Setup Script for vProfile Application
# This script installs and configures MySQL on Amazon Linux 2

# Update system
sudo yum update -y

# Install MySQL
sudo yum install -y mysql-server

# Start MySQL service
sudo systemctl start mysqld
sudo systemctl enable mysqld

# Secure MySQL installation (you'll need to set root password manually)
# sudo mysql_secure_installation

# Create database and user for vProfile application
sudo mysql -e "CREATE DATABASE accounts;"
sudo mysql -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin123';"
sudo mysql -e "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Import database schema (if you have a SQL file)
# sudo mysql accounts < /path/to/your/schema.sql

echo "MySQL setup completed successfully!"
