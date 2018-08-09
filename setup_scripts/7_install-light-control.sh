#!/bin/bash

echo 'Installing backlight control...'

cd /tmp
git clone https://github.com/haikarainen/light.git

cd light
./autogen.sh
./configure && make
sudo make install

echo 'DONE!'


