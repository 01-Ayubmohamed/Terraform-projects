#!/bin/bash
set -e

# ---------------------------
# Variables injected by Terraform
# ---------------------------
DB_NAME="${DB_NAME}"
DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"
DB_HOST="${DB_HOST}"

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
cp -r wordpress/* ${web_dir}

chown -R apache:apache ${web_dir}
chmod -R 755 ${web_dir}

# ---------------------------
# Configure WordPress to use RDS
# ---------------------------
cp ${web_dir}/wp-config-sample.php ${web_dir}/wp-config.php

sed -i "s/database_name_here/${DB_NAME}/" ${web_dir}/wp-config.php
sed -i "s/username_here/${DB_USER}/" ${web_dir}/wp-config.php
sed -i "s/password_here/${DB_PASSWORD}/" ${web_dir}/wp-config.php
sed -i "s/localhost/${DB_HOST}/" ${web_dir}/wp-config.php

# ---------------------------
# Restart Apache
# ---------------------------
systemctl restart httpd
