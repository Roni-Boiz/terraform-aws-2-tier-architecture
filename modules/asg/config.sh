#!/bin/bash

# Variables
FRONTEND_REPO_URL='https://github.com/Roni-Boiz/crispy-kitchen-frontend.git'
FRONTEND_ART_NAME="crispy-kitchen-frontend"
FRONTEND_DIR="/var/www/html/"

BACKEND_REPO_URL='https://github.com/Roni-Boiz/crispy-kitchen-backend.git'
BACKEND_ART_NAME="crispy-kitchen-backend"
BACKEND_DIR="/var/www/backend/"

# Set your desired Node.js version
NODE_VERSION="20.x"

# Set Variables for Ubuntu
PACKAGE="apache2 wget unzip curl git mysql-server"
SVC="apache2"

echo "Running Setup on Ubuntu"

# Installing Dependencies
echo "########################################"
echo "Installing packages."
echo "########################################"
sudo apt update
sudo apt install $PACKAGE -y > /dev/null
echo

# Install Node.js
echo "########################################"
echo "Installing Node.js"
echo "########################################"
curl -sL https://deb.nodesource.com/setup_$NODE_VERSION -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install -y nodejs
echo

# Create Data Tables
echo "########################################"
echo "Create Data Tables"
echo "########################################"
sudo mysql -h "${db_host}" -u "${db_user}" -p"${db_password}" < "${db_file}"

# Start & Enable Service
echo "########################################"
echo "Start & Enable HTTPD Service"
echo "########################################"
sudo systemctl enable $SVC
sudo systemctl start $SVC
echo

# Clone Frontend Repository
echo "########################################"
echo "Cloning Frontend Repository"
echo "########################################"
sudo rm -rf ${FRONTEND_DIR}*
sudo git clone $FRONTEND_REPO_URL $FRONTEND_DIR
echo

# Bounce Service
echo "########################################"
echo "Restarting HTTPD service"
echo "########################################"
sudo systemctl restart $SVC
echo

# Clone Backend Repository
echo "########################################"
echo "Cloning Backend Repository"
echo "########################################"
sudo git clone $BACKEND_REPO_URL $BACKEND_DIR
cd $BACKEND_DIR
echo

# Install Backend Dependencies
echo "########################################"
echo "Installing Backend Dependencies"
echo "########################################"
npm install
echo

# Set environment variables for the database
echo "########################################"
echo "Export Environment Variables"
echo "########################################"
export DB_HOST="${db_host}"
export DB_PORT="${db_port}"
export DB_USER="${db_user}"
export DB_PASSWORD="${db_password}"
export DB_NAME="${db_name}"

# Start Backend Server
echo "########################################"
echo "Starting Backend Server"
echo "########################################"
nohup npm start > backend.log 2>&1 &
echo

# Clean Up
echo "########################################"
echo "Removing Temporary Files"
echo "########################################"
sudo rm -rf /tmp
echo "Cleanup Done"
echo "Setup Complete"
