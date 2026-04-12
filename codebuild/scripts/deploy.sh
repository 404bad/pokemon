#!/bin/bash

# Authenticate Docker to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 891377131628.dkr.ecr.us-east-1.amazonaws.comS

# Go to app directory
cd /home/ubuntu/pokemon-app

# Pull latest image and restart containers
docker compose up -d --force-recreate
Make the script executable before committing:

chmod +x scripts/deploy.sh
git add .
git commit -m "add cicd files"
git push origin dev