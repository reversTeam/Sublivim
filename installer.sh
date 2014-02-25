#!/bin/sh

tar -xf old-vim.tar ~/.vim ~/.vimrc

tar -xf sv.tar
mv .vimrc ~/
mv .vim ~/

wget http://norminator.clem.org/norminator
chmod +x norminator
mv norminator ~/shells/

