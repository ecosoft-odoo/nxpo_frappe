#!/bin/bash

# Go to nxpo_frappe
frappe_path=$(dirname "$(realpath "$0")")
cd $frappe_path

# Update submodule
git submodule init
git submodule update --remote

# Build Image
export APPS_JSON_BASE64=$(base64 -w 0 apps.json)
cd frappe_docker
docker build --no-cache --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 --tag=ecosoft/nxpo_frappe:latest --file images/custom/Containerfile .

# Create docker-compose.yaml
export CUSTOM_IMAGE='ecosoft/nxpo_frappe'
export CUSTOM_TAG='latest'
export ERPNEXT_VERSION='latest'
export DB_PASSWORD='nXp@MYSql'
export PULL_POLICY='never'
docker compose -f compose.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml -f overrides/compose.proxy.yaml config > ../docker-compose.yaml

# Start frappe
docker compose -f ../docker-compose.yaml up -d

# Bench new site
docker exec frappe_docker-backend-1 bench new-site localhost --mariadb-root-password nXp@MYSql --admin-password admin
