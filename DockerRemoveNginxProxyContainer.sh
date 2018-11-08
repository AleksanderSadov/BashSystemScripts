#!/bin/bash

proxyContainerName=nginx-proxy
if ! sudo docker container ls | grep ${proxyContainerName} > /dev/null; then
    echo "INFO: '${proxyContainerName}' is not running"
    exit 0
fi

sudo docker container stop ${proxyContainerName} > /dev/null && sudo docker container rm ${proxyContainerName} > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to remove '${proxyContainerName}' container" >&2
    exit 1
fi
echo "SUCCESS: '${proxyContainerName}' container removed"
