#!/bin/bash

echo "==============================="
echo " Deploying EKART to DEV "
echo "==============================="

APP_NAME="shopping-cart"
WORKSPACE="/var/snap/jenkins/4983/workspace/EKART-MULTIBRANCH_develop"
JAR_FILE=$(ls $WORKSPACE/target/*.jar)
LOG_FILE="$WORKSPACE/ekart-dev.log"

echo "Stopping existing EKART app (if any)..."
pkill -f $APP_NAME || true

echo "Starting EKART application in background..."
nohup java -jar $JAR_FILE > $LOG_FILE 2>&1 &

sleep 5

echo "Checking running process..."
ps -ef | grep $APP_NAME | grep -v grep

echo "EKART DEV deployment completed"
echo "Application should be running on port 8081"
