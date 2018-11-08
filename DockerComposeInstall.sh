#!/bin/bash

if which docker-compose > /dev/null; then
    echo "INFO: 'docker-compose' is already installed"
    exit 0
fi

echo "INFO: Installing docker-compose"

sudo apt-get install curl -y -qq > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to install curl"
    exit 1
fi

tagName=$(curl -s -L https://api.github.com/repos/docker/compose/releases/latest | grep "tag_name" | sed -E 's/.*"([^"]+)".*/\1/') > /dev/null
if [[ -z ${tagName} ]]; then
    echo "ERROR: Unable to get latest docker-compose version" >&2
    exit 1
fi

sudo curl -s -L https://github.com/docker/compose/releases/download/${tagName}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to download docker-compose" >&2
    exit 1
fi

sudo chmod +x /usr/local/bin/docker-compose > /dev/null
if [[ $? -ne 0 ]]; then
    echo "WARNING: Unable to set execute permissions for /usr/local/bin/docker-compose" >&2
fi

sudo curl -s -L https://raw.githubusercontent.com/docker/compose/${tagName}/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose > /dev/null
if [[ $? -ne 0 ]]; then
    echo "WARNING: Unable to download docker-compose bash-completion" >&2
fi

echo "SUCCESS: docker-compose installed"
