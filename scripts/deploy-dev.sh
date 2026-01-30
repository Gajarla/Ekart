#!/bin/bash

echo "==============================="
echo " Deploying EKART to DEV "
echo "==============================="

APP_NAME="shopping-cart"
APP_JAR=$(ls target/*.jar)
LOG_FILE="ekart-dev.log"

echo "Stopping existing EKART application if running..."
pkill -f ${APP_NAME} || true

echo "Starting EKART application in background..."
nohup java -jar ${APP_JAR} > ${LOG_FILE} 2>&1 &

sleep 5

echo "EKART DEV deployment completed successfully"
echo "Application running on port 8081"
