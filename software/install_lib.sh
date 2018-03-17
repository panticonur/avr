#!/bin/sh
make -B
sudo cp -fv libtemplate.so /usr/local/lib/libtemplate.so
sudo chmod 0755 /usr/local/lib/libtemplate.so
sudo ldconfig -v | grep libtemplate
