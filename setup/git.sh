#!/bin/sh

git config --global user.name "Igor P. Leroy"
git config --global user.email ip.leroy@gmail.com

chmod 700 ~/.ssh
chmod 644 ~/.ssh/config
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
