#!/bin/bash
set -e

# ---------------------------
# Variables injected by Terraform
# ---------------------------
DB_NAME="${db_name}"
DB_USER="${db_username}"
DB_PASSWORD="${db_password}"
DB_HOST="${db_endpoint}"

WEB_DIR="/var/www/html"

# ---------------------------
# System update
# ---------------------------
yum update -y

# ---------------------------
# Install Apache
# ---------------------------
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# ---------------------------
# Install PHP (WordPress requirements)
# ---------------------------
amazon-linux-extras enable php8.1 -y
yum install -y php php-mysqlnd php-fpm php-json php-gd php-mbstring php-xml php-curl php-zip

# ---------------------------
# Download & configure WordPress
# ---------------------------
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* ${WEB_DIR}

chown -R apache:apache ${WEB_DIR}
chmod -R 755 ${WEB_DIR}

# ---------------------------
# Configure WordPress to use RDS
# ---------------------------
cp ${WEB_DIR}/wp-config-sample.php ${WEB_DIR}/wp-config.php

sed -i "s/database_name_here/${DB_NAME}/" ${WEB_DIR}/wp-config.php
sed -i "s/username_here/${DB_USER}/" ${WEB_DIR}/wp-config.php
sed -i "s/password_here/${DB_PASSWORD}/" ${WEB_DIR}/wp-config.php
sed -i "s/localhost/${DB_HOST}/" ${WEB_DIR}/wp-config.php

# ---------------------------
# Restart Apache
# ---------------------------
systemctl restart httpd
