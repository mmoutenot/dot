#!/bin/bash
echo 'Installing fish shell'

sudo apt install fish
chsh -s /usr/bin/fish

echo 'Installing oh my fish...'

curl -L https://get.oh-my.fish | fish

echo 'Get some good fonts...'

sudo apt install fonts-powerline fonts-firacode fonts-font-awesome

echo 'Done...'
