#!/bin/bash

proxyContainerName=nginx-proxy
if sudo docker container ls | grep ${proxyContainerName} > /dev/null; then
    echo "INFO: '${proxyContainerName}' is already running"
    exit 0
fi

echo "INFO: Starting nginx proxy container
        For more information see: https://github.com/jwilder/nginx-proxy"
sudo docker run -d --restart=always -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro --name=${proxyContainerName} jwilder/nginx-proxy > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to start nginx proxy container" >&2
    exit 1
fi
echo "SUCCESS: nginx proxy container started"
