#!/bin/bash

# Set environment variable
export CUSTOM_IMAGE="ecosoft/nxpo_frappe"
export CUSTOM_TAG="1.0"
export ERPNEXT_VERSION="latest"
export PULL_POLICY="never"
# --
export ADMIN_PASSWORD="admin"
export DB_PASSWORD="nxpopwd"
export SITE="localhost"

# Next image tag = 1.<minor version>
# When run this script, minor version will plus 1 from original image
latest_image=$(docker images --filter=reference="$CUSTOM_IMAGE:*" --format "{{.Repository}}:{{.Tag}}" | sort -r | head -n 1)
if [ -n "$latest_image" ]; then
    major_version=$(echo ${latest_image#*:} | cut -d '.' -f 1)
    minor_version=$(echo ${latest_image#*:} | cut -d '.' -f 2)
    export CUSTOM_TAG="$major_version.$((minor_version + 1))"
fi

# Go to nxpo_frappe directory
frappe_path=$(dirname "$(realpath "$0")")
cd $frappe_path

# Update submodule
git submodule init
git submodule update --remote

# Build image
export APPS_JSON_BASE64=$(base64 -w 0 apps.json)
cd frappe_docker
docker build --no-cache --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 --tag=$CUSTOM_IMAGE:$CUSTOM_TAG --file images/custom/Containerfile .

# Start frappe
image_from_build=$(docker images --filter=reference="$CUSTOM_IMAGE:$CUSTOM_TAG" --format "{{.Repository}}:{{.Tag}}")
if [ -n "$image_from_build" ]; then
    docker compose --project-name nxpo-frappe -f compose.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml -f overrides/compose.proxy.yaml config > ../docker-compose.yaml
    docker compose --project-name nxpo-frappe -f ../docker-compose.yaml up -d
    docker compose --project-name nxpo-frappe -f ../docker-compose.yaml exec backend bench new-site $SITE --mariadb-root-password $DB_PASSWORD --admin-password $ADMIN_PASSWORD
fi

# Remove all images not used in container
docker images --filter=reference="$CUSTOM_IMAGE:*" --format "{{.Repository}}:{{.Tag}}" | while read image; do
    if ! docker ps -a --format '{{.Image}}' | grep -q "$image"; then
        docker rmi "$image"
    fi
done

exit 0
