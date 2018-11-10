#!/bin/bash

declare -r packageName="git"
declare -r binPath="$(which ${packageName})"
if [[ -z "${binPath}" ]]; then
    echo "INFO: '${packageName}' is not installed"
    exit 0
fi

echo "INFO: Removing '${packageName}'"
sudo apt-get purge "${packageName}" -qq > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to remove '${packageName}'" >&2
    exit 1
fi

echo "SUCCESS: '${packageName}' removed"
