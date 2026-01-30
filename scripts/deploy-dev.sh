#!/bin/bash
set -e

echo "==============================="
echo " Deploying EKART to DEV "
echo "==============================="

APP_DIR="/opt/ekart/app"
JAR_NAME="shopping-cart-0.0.1-SNAPSHOT.jar"

echo "Stopping service..."
sudo systemctl stop ekart-dev || true

echo "Copying JAR..."
sudo cp target/${JAR_NAME} ${APP_DIR}/

echo "Setting permissions..."
sudo chown root:root ${APP_DIR}/${JAR_NAME}

echo "Starting service..."
sudo systemctl start ekart-dev

echo "Checking status..."
sudo systemctl status ekart-dev --no-pager

echo "EKART DEV deployed successfully 🚀"
