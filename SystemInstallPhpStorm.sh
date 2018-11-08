#!/bin/bash

echo "INFO: Installing phpstorm"

packagePath="/opt/phpstorm"
if [[ -d "${packagePath}" ]]; then
    echo "INFO: phpstorm is already installed"
fi

sudo apt-get install curl -y -qq > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to install curl"
    exit 1
fi

downloadPath="https://data.services.jetbrains.com/products/download?code=PS&platform=linux"
outputPath="/opt/phpstorm.tar.gz"
sudo curl -s -L "${downloadPath}" -o "${outputPath}" > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to download phpstorm
       Refer to manual installation at: https://www.jetbrains.com/phpstorm/" >&2
    exit 1
fi

sudo mkdir "${packagePath}"
if [[ $? -ne 0 ]]; then
    echo "ERROR: Cannot create directory '${packagePath}'"
    sudo rm "${outputPath}" > /dev/null
    exit 1
fi

sudo tar -xzf "${outputPath}" -C "${packagePath}" --strip-components 1 > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to extract phpstorm package in '${outputPath}'"
    exit 1
fi
sudo rm "${outputPath}" > /dev/null

if [[ ! -d "$packagePath" ]]; then
    echo "ERROR: cannot extract '${outputPath}' to '${packagePath}'"
    exit 1
fi

binPath="${packagePath}/bin"
installerName="phpstorm.sh"
installerPath="${binPath}/${installerName}"
cd "${binPath}"
if [[ ! -f "${installerPath}" ]]; then
    echo "ERROR: Unable to locate installer script '${installerPath}'"
    exit 1
fi

echo "SUCCESS: phpstorm configuration will start now"
nohup ./phpstorm.sh > /dev/null 2>&1 &

