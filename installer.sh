#!/bin/bash
set -e

function get_platformsh_config_value() {
    local property="$1"
    local value=$(echo "$PLATFORM_RELATIONSHIPS" | base64 --decode | jq -r "$property")
    echo "$value"
}

PIMCORE_INSTALL_MYSQL_USERNAME=pimcore
PIMCORE_INSTALL_MYSQL_PASSWORD=pimcore
PIMCORE_INSTALL_MYSQL_DATABASE=pimcore
PIMCORE_INSTALL_MYSQL_HOST_SOCKET=db
PIMCORE_INSTALL_MYSQL_PORT=3306

if [ -n "$PLATFORM_RELATIONSHIPS" ]; then
    PIMCORE_INSTALL_MYSQL_USERNAME=$(get_property_value ".database[0].username")
    PIMCORE_INSTALL_MYSQL_PASSWORD=$(get_property_value ".database[0].password")
    PIMCORE_INSTALL_MYSQL_DATABASE=$(get_property_value ".database[0].path")
    PIMCORE_INSTALL_MYSQL_HOST_SOCKET=$(get_property_value ".database[0].host")
    PIMCORE_INSTALL_MYSQL_PORT=$(get_property_value ".database[0].port")
fi

export PIMCORE_INSTALL_MYSQL_USERNAME
export PIMCORE_INSTALL_MYSQL_PASSWORD
export PIMCORE_INSTALL_MYSQL_DATABAS
export PIMCORE_INSTALL_MYSQL_HOST_SOCKET
export PIMCORE_INSTALL_MYSQL_PORT

export PIMCORE_INSTALL_ADMIN_USERNAME='admin'
export PIMCORE_INSTALL_ADMIN_PASSWORD='admin'

./vendor/bin/pimcore-install --no-interaction --ignore-existing-config