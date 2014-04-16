#!/bin/sh
SV_VERSION="0"
SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"

cd ~
if [ -d $HOME/.Sublivim ]; then
	echo "Mise a jour du Sublivim"
	(cd .Sublivim && git pull)
else
	echo "Clone du depot"
	git clone https://github.com/reversTeam/Sublivim.git .Sublivim

	if [ -d $HOME/.vim ] && [ -f $HOME/.vimrc ]; then
		echo "Sauvegarde de vos anciennes configurations Vim : ~/old-conf-vim.tar"
		tar -cf old-conf-vim.tar .vim .vimrc
		rm -rf .vim .vimrc
	fi

	echo "Installation du Sublivim"
	ln -s .Sublivim/vimrc ~/.vimrc 
	ln -s .Sublivim/vim ~/.vim
fi
cd - > /dev/null
