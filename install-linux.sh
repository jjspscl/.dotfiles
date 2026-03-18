#!/bin/bash
set -x
 
sudo apt-get update 
sudo apt-get -y upgrade

sudo apt install build-essential

curl https://sh.rustup.rs -sSf | sh

cargo install tuckr
