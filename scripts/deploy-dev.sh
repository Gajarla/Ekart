#!/bin/bash

APP_NAME=shopping-cart
JAR_NAME=shopping-cart-0.0.1-SNAPSHOT.jar

WORKSPACE_JAR=/var/snap/jenkins/4983/workspace/EKART-MULTIBRANCH_develop/target/$JAR_NAME
DEPLOY_DIR=/opt/ekart/app
LOG_DIR=/opt/ekart/logs
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

echo "==============================="
echo " Deploying EKART to DEV "
echo "==============================="

mkdir -p $DEPLOY_DIR $LOG_DIR

echo "Stopping existing app (if any)..."
pkill -f $APP_NAME || true
sleep 3

echo "Copying JAR to runtime directory..."
cp $WORKSPACE_JAR $DEPLOY_DIR/

echo "Starting app..."
nohup $JAVA_HOME/bin/java \
  -jar $DEPLOY_DIR/$JAR_NAME \
  --spring.profiles.active=dev \
  > $LOG_DIR/ekart-dev.log 2>&1 &

sleep 5

echo "Checking running process..."
ps -ef | grep $APP_NAME | grep -v grep

echo "EKART DEV started on port 8081"
