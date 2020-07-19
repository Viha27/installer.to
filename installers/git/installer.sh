#!/bin/sh

CURL_CMD=$(which curl)
YUM_CMD=$(which yum)
DNF_CMD=$(which dnf)
APT_GET_CMD=$(which apt-get)
PACMAN_CMD=$(which pacman)
APK_CMD=$(which apk)
GIT_CMD=$(which git)
SUDO_CMD=$(which sudo)

USER="$(id -un 2>/dev/null || true)"
SUDO=''
if [ "$USER" != 'root' ]; then
	if [ ! -z $SUDO_CMD ]; then
		SUDO='sudo'
	else
		cat >&2 <<-'EOF'
		Error: this installer needs the ability to run commands as root.
		We are unable to find "sudo". Make sure its available to make this happen
		EOF
		exit 1
	fi
fi

if [ ! -z $APT_GET_CMD ]; then
   $SUDO apt-get update
   $SUDO apt-get install git

elif [ ! -z $YUM_CMD ]; then
   $SUDO yum install git

elif [ ! -z $PACMAN_CMD ]; then
   pacman -Sy git

elif [ ! -z $DNF_CMD ]; then
   $SUDO dnf install git

elif [ ! -z $APK_CMD ]; then
   $SUDO apk add git

else
   echo "Couldn't install package"
   exit 1;
fi
