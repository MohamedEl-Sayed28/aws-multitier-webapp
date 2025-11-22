#!/bin/bash

# Tomcat Setup Script for vProfile Application
# This script installs Tomcat and deploys the vProfile application

# Update system
sudo yum update -y

# Install Java 11
sudo yum install -y java-11-openjdk-devel

# Install Tomcat 9
sudo yum install -y tomcat tomcat-webapps tomcat-admin-webapps

# Install AWS CLI (if not already installed)
sudo yum install -y aws-cli

# Download application artifact from S3
# Replace YOUR_BUCKET_NAME with your actual S3 bucket name
aws s3 cp s3://YOUR_BUCKET_NAME/vprofile-v2.war /usr/share/tomcat/webapps/ROOT.war

# Create application properties file with backend service endpoints
sudo tee /usr/share/tomcat/webapps/ROOT/WEB-INF/classes/application.properties > /dev/null <<EOF
# Database Configuration
jdbc.driverClassName=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://db01.vprofile.internal:3306/accounts?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull
jdbc.username=admin
jdbc.password=admin123

# RabbitMQ Configuration
rabbitmq.address=rmq01.vprofile.internal
rabbitmq.port=5672
rabbitmq.username=admin
rabbitmq.password=admin123

# Memcached Configuration
memcached.active.host=mc01.vprofile.internal
memcached.active.port=11211
EOF

# Set proper permissions
sudo chown -R tomcat:tomcat /usr/share/tomcat/webapps/

# Start Tomcat service
sudo systemctl start tomcat
sudo systemctl enable tomcat

# Check if Tomcat is running
sleep 10
sudo systemctl status tomcat

echo "Tomcat setup completed successfully!"
echo "Application should be accessible on port 8080"
```
