#!/bin/bash

if which docker > /dev/null; then
    echo "INFO: 'docker' is already installed"
    exit 0
fi

echo "INFO: Installing docker-ce package"

sudo apt-get install curl -y -qq > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to install curl"
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
curl -fsSL https://get.docker.com -o ${SCRIPT_DIR}/get-docker.sh > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to get docker convenience script with curl" >&2
    exit 1
fi

sudo sh ${SCRIPT_DIR}/get-docker.sh > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to install docker through convenience script" >&2
    rm get-docker.sh
    exit 1
fi
echo "INFO: docker-ce installed"

sudo rm ${SCRIPT_DIR}/get-docker.sh
if [[ $? -ne 0 ]]; then
    echo "WARNING: Unable to delete used get-docker.sh" >&2
fi

${SCRIPT_DIR}/DockerComposeInstall.sh

${SCRIPT_DIR}/DockerRunNginxProxyContainer.sh

echo "INFO: Adding current user to 'docker' group"
currentUser=$(printenv USER)
sudo usermod -aG docker ${currentUser}
if [[ $? -ne 0 ]]; then
    echo "WARNING: Unable to add current user to 'docker' group
        In order to use 'docker' commands from current user
        it must be added to 'docker' group" >&2
fi

echo "INFO: You will have to log out and back in order
        for group changes to take effect
        and use 'docker' commands from current user!"

echo "SUCCESS: docker installed"
