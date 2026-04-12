#!/bin/bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 533267438223.dkr.ecr.us-east-1.amazonaws.com

cd /home/ubuntu/pokemon-app

docker compose up -d --force-recreate