#!/bin/bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 290657649733.dkr.ecr.us-east-1.amazonaws.com

cd /home/ubuntu/pokemon-app

docker compose pull

docker compose up -d --force-recreate