#!/bin/bash

declare -r packageName="git"
if which "${packageName}" > /dev/null; then
    echo "INFO: '${packageName}' is already installed"
    exit 0
fi

echo "INFO: Installing '${packageName}'"
sudo apt-get install git -qq > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to install '${packageName}"
    exit 1
fi

echo "SUCCESS: '${packageName}' is installed"
