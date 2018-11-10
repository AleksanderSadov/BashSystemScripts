#!/bin/bash

declare -r packageName="virtualbox"

echo "INFO: Installing '${packageName}'"

sudo apt-get install -qq \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    > /dev/null
if [[ $? -ne 0 ]]; then
    echo "Unable to add '{$packageName}' repository"
    exit 1
fi

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add - > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to download and add oracle public key"
    exit 1
fi
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to download and add oracle public key"
    exit 1
fi

declare -r dist_codename="$(lsb_release -cs)"
sudo add-apt-repository "deb https://download.virtualbox.org/virtualbox/debian ${dist_codename} contrib" > /dev/null
if [[ $? -ne 0 ]]; then
    echo "Unable to add '{$packageName}' repository"
    exit 1
fi

sudo apt-get update -qq > /dev/null
apt-cache search virtualbox | grep "virtualbox-[0-9]." | sort -r
