#!/bin/bash

echo 'Executing steps outline here: https://www.dell.com/support/article/us/en/04/sln308258/precision-xps-ubuntu-general-touchpad-mouse-issue-fix?lang=en'


echo 'TODO: not complete'

echo 'In the meantime, here is a quick fix...'

sudo apt install libinput-tool gnome-tweaks

cat << EOF

Option "NaturalScrolling" "true"
Option "Tapping" "true"

EOF

read -p "Now you have to paste the above into the touchpad section. Ready?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  sudo vim /usr/share/X11/xorg.conf.d/40-libinput.conf
fi

