#!/bin/bash

packageName=jq
if ! which ${packageName} > /dev/null; then
    echo "INFO: '${packageName}' is not installed"
    exit 0
fi

binPath=$(which jq)
sudo rm ${binPath} > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to remove '${binPath}'" >&2
    exit 1
fi

echo "SUCCESS: '${packageName}' removed"
