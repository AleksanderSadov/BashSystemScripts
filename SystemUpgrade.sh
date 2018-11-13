#!/bin/bash

echo "INFO: Updating packages list"
sudo apt-get update -qq > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to update packages list" >&2
    exit 1
fi

echo "INFO: Upgrading packages"
sudo apt-get upgrade --with-new-pkgs -qq > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to upgrade packages" >&2
    exit 1
fi

echo "INFO: Cleaning unneeded packages"
sudo apt-get autoremove -qq > /dev/null
if [[ $? -ne 0 ]]; then
    echo "WARNING: Unable to clean unneeded packages with apt-get autoremove" >&2
    exit 1
fi

echo "SUCCESS: System upgrade completed"
