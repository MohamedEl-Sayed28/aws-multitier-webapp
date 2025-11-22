#!/bin/bash

# RabbitMQ Setup Script for vProfile Application
# This script installs and configures RabbitMQ on Amazon Linux 2

# Update system
sudo yum update -y

# Install Erlang (required for RabbitMQ)
sudo yum install -y erlang

# Add RabbitMQ repository
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash

# Install RabbitMQ
sudo yum install -y rabbitmq-server

# Start RabbitMQ service
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server

# Enable RabbitMQ Management Console
sudo rabbitmq-plugins enable rabbitmq_management

# Create admin user
sudo rabbitmqctl add_user admin admin123
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

# Remove guest user (security best practice)
sudo rabbitmqctl delete_user guest

echo "RabbitMQ setup completed successfully!"
echo "Management console available at: http://YOUR_IP:15672"
echo "Username: admin, Password: admin123"
