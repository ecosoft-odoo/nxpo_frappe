#!/bin/bash

# Go to nxpo_frappe directory
frappe_path=$(dirname "$(realpath "$0")")
cd $frappe_path

# Call bench command
docker compose --project-name nxpo-frappe -f docker-compose.yaml exec backend bench $@

exit 0
