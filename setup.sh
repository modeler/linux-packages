#!/bin/bash

#
# 3rd. Identifies the Linux distro and sets up the build environment.
#

if [[ $(which pacman) ]]; then
  DISTRO=arch
elif [[ $(which rpm) ]]; then
  DISTRO=redhat
else
  DISTRO=debian
fi

export DISTRO

case "${DISTRO}" in

arch)
sudo pacman -S --needed --noconfirm base-devel git subversion
;;

redhat)
sudo yum -y groupinstall "Development Tools"
sudo yum -y install rpmdevtools git subversion
rpmdev-setuptree
;;

debian)
sudo apt -y install build-essential dh-make git subversion
;;

esac
