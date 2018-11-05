#!/bin/bash -x

sudo apt update && sudo apt upgrade --with-new-pkgs -y && sudo apt autoremove -y
: "System upgrade completed"