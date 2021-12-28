#!/bin/bash

# Update all existing packages installed in the image.
echo -e "- Updating already installed packages -"
yum update -y

# Install packages that will be useful in WSL.
echo -e "- Installing packages -"
yum install -y sudo passwd dnf vim wget util-linux readline net-tools openssh openssl zip unzip

# Cleanup unused packages to make the image smaller.
echo -e "- Cleaning up -"
yum autoremove -y
yum clean all