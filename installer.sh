#!/bin/sh
SV_VERSION="0"
SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"

cd ~

git clone https://github.com/reversTeam/Sublivim.git .Sublivim

if [ -d $HOME/.vim ] && [ -f $HOME/.vimrc ]; then
	echo "Sauvegarde de vos anciennes configurations Vim : ~/old-conf-vim.tar"
	tar -cf old-conf-vim.tar .vim .vimrc
	rm -rf .vim .vimrc
fi

echo "Installation du Sublivim"
ln -s Sublivim/vimrc ~/.vimrc 
ln -s .Sublivim/vim ~/.vim

cd -
