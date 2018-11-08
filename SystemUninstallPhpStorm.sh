#!/bin/bash

packageDir=/opt/phpstorm
if [[ ! -d ${packageDir} ]]; then
    echo "INFO: phpstorm is not installed"
    exit 0
fi

sudo rm ${packageDir} -R > /dev/null
if [[ $? -ne 0 ]]; then
    echo "ERROR: Unable to remove '${packageDir}'" >&2
    exit 1
fi

settingsDirectory="$(find ~ -type d -iname '.PhpStorm*')"
if [[ ! -z "${settingsDirectory}" ]]; then
    sudo rm "${settingsDirectory}" -R > /dev/null
    if [[ $? -ne 0 ]]; then
        echo "WARNING: Unable to remove settings directory '${settingsDirectory}'"
    fi
fi

desktopEntryName="jetbrains-phpstorm.desktop"
userDesktopEntry="/home/$USER/.local/share/applications/${desktopEntryName}"
if [[ -f ${userDesktopEntry} ]]; then
    sudo rm ${userDesktopEntry} > /dev/null
    if [[ $? -ne 0 ]]; then
        echo "WARNING: Cannot remove desktop entry at '${userDesktopEntry}'"
    fi
fi

allDesktopEntry="/usr/share/applications/${desktopEntryName}"
if [[ -f ${allDesktopEntry} ]]; then
    sudo rm ${allDesktopEntry} > /dev/null
    if [[ $? -ne 0 ]]; then
        echo "WARNING: Cannot remove desktop entry at '${allDesktopEntry}'"
    fi
fi

binName="pstorm"
binPath="$(which ${binName})"
if [[ ! -z "${binPath}" ]]; then
    sudo rm "${binPath}" > /dev/null
    if [[ $? -ne 0 ]]; then
        echo "WARNING: Unable to remove '${binPath}'" >&2
        exit 1
    fi
fi

echo "SUCCESS: '${packageDir}' removed"

