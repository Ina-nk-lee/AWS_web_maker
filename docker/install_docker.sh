#!/bin/bash

# install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
chmod 777 get-docker.sh
./get-docker.sh

# build and run was Docker compose
docker compose up -d