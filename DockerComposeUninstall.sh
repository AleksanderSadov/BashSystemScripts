#!/bin/bash

if ! which docker-compose > /dev/null; then
    echo "INFO: 'docker-compose' is not installed"
    exit 0
fi

echo "INFO: Removing docker-compose"
if [[ -f /usr/local/bin/docker-compose ]]; then
    sudo rm /usr/local/bin/docker-compose > /dev/null
    if [[ $? -ne 0 ]]; then
        echo "ERROR: Unable to remove /usr/local/bin/docker-compose" >&2
        exit 1
    fi
fi

if [[ -f /usr/local/bin/docker-compose ]]; then
    sudo rm /etc/bash_completion.d/docker-compose > /dev/null
    if [[ $? -ne 0 ]]; then
        echo "WARNING: Unable to remove /etc/bash_completion.d/docker-compose" >&2
    fi
fi

echo "SUCCESS: docker-compose removed"
