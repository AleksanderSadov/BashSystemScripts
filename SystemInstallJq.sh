#!/bin/bash

if which jq > /dev/null; then
    echo "INFO: jq is already installed"
    exit 0
fi

echo "INFO: Checking latest version of jq"

releasePath="https://api.github.com/repos/stedolan/jq/releases/latest"
tagName=$(curl -s -L ${releasePath} | grep "tag_name" | sed -E 's/.*"([^"]+)".*/\1/') > /dev/null
if [[ -z ${tagName} ]]; then
    echo "ERROR: Unable to get latest jq version" >&2
    exit 1
fi

echo "INFO: Checking your cpu architecture"
is64os=false
uname -m | grep -E 'x86_64|armv[8-9]|armv[0-9]{2,}' > /dev/null && is64os=true
osBit="32"
if ${is64os}; then
    echo "INFO: 64bit os detected"
    osBit="64"
else
    echo "INFO: 32bit os detected"
fi

outputPath="/usr/local/bin/jq"
downloadPath="https://github.com/stedolan/jq/releases/download/${tagName}/jq-linux${osBit}"
sudo curl -s -L ${downloadPath} -o ${outputPath} > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to download jq
       Refer to manual installation at: https://stedolan.github.io/jq/" >&2
    exit 1
fi

sudo chmod a+x ${outputPath}
if [[ $? -ne 0 ]]; then
    echo "WARNING: Unable to set executable permission for '${outputPath}'"
fi
echo "SUCCESS: jq downloaded and placed into local path '${outputPath}'"
