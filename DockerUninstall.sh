#!/bin/bash

if ! which docker > /dev/null; then
    echo "INFO: 'docker' is not installed"
    exit 0
fi

echo "INFO: Stopping and removing all containers"
sudo docker container stop $(docker container ls -a -q) > /dev/null
sudo docker container rm $(docker container ls -a -q) > /dev/null

echo "INFO: Uninstalling docker-ce package"
sudo apt-get purge -qq docker-ce > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to uninstall docker-ce package" >&2
    exit 1
fi

echo "INFO: Cleaning packages with apt autoremove"
sudo apt-get -qq autoremove > /dev/null
if [[ $? -ne 0 ]]; then
    echo "WARNING: Unable to clean packages with apt autoremove" >&2
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
${SCRIPT_DIR}/DockerComposeUninstall.sh

currentUser=$(printenv USER)
echo "INFO: Removing current user from 'docker' group"
groups ${currentUser} | grep 'docker' > /dev/null
if [[ $? -eq 0 ]]; then
    sudo deluser ${currentUser} docker > /dev/null
    if [[ $? -ne 0 ]]; then
        echo "WARNING: Unable to remove current user from 'docker' group" >&2
    fi
fi

echo "INFO: Deleting all images, container, volumes, configuration"
sudo rm -rf /var/lib/docker > /dev/null
if [[ $? -ne 0 ]]; then
    echo "WARNING: Unable to delete docker images, containers, volumes, configurations" >&2
fi
echo "INFO: You must delete any edited configuration files manually"

echo "SUCCESS: docker removed"
