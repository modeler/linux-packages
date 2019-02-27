#!/bin/bash

if [[ $(which pacman) ]]; then
  export DISTRO=arch
elif [[ $(which rpm) ]]; then
  export DISTRO=redhat
else
  export DISTRO=debian
fi

case "${DISTRO}" in

arch)
sudo pacman -S --noconfirm base-devel git
;;

redhat)
sudo yum -y groupinstall "Development Tools"
sudo yum -y install rpmdevtools git
rpmdev-setuptree
;;

debian)
sudo apt -y install build-essential dh-make git
;;

esac
