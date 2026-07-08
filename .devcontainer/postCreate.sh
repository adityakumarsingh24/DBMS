#!/bin/bash

set -e

echo "Updating packages..."

sudo apt-get update

sudo apt-get install -y \
wget \
unzip \
default-jre

echo "Downloading SQLcl..."

wget -q -O sqlcl.zip \
https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip

echo "Extracting..."

unzip -q sqlcl.zip

echo "Adding SQLcl to PATH..."

echo "export PATH=\$PATH:$(pwd)/sqlcl/bin" >> ~/.bashrc

export PATH=$PATH:$(pwd)/sqlcl/bin

echo "Done."