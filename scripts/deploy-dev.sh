#!/bin/bash

JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
JAR_PATH=/var/snap/jenkins/4983/workspace/EKART-MULTIBRANCH_develop/target
LOG_PATH=/var/log/ekart

mkdir -p $LOG_PATH

echo "==============================="
echo " Deploying EKART to DEV "
echo "==============================="

echo "Stopping existing app..."
pkill -f shopping-cart || true
sleep 2

echo "Starting app with Java 8..."
nohup $JAVA_HOME/bin/java \
-jar $JAR_PATH/shopping-cart-0.0.1-SNAPSHOT.jar \
> $LOG_PATH/ekart-dev.log 2>&1 &

sleep 5
ps -ef | grep shopping-cart | grep -v grep

echo "EKART DEV started on port 8081"
