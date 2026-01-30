#!/bin/bash
echo "Deploying EKART to DEV"

java -jar target/*.jar --spring.profiles.active=dev
