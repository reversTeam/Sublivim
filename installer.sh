#!/bin/sh
SV_VERSION="0"
SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"

cd ~
if [ -d $HOME/.Sublivim ]; then
	echo "Mise a jour du Sublivim" > /dev/null
	(cd .Sublivim && git stash > /dev/null 2> /dev/null && git pull > /dev/null 2> /dev/null &)
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
if [ -f ~/.Sublivim/config_perso ]; then
	echo "let g:syntastic_c_include_dirs = ['../../../include', '../../include','../include','./include']" > ~/.Sublivim/config_perso
fi

SHELLRC=`cat $SHELL_ACTIVE | grep "source ~/.Sublivim/sublivimrc.sh"`

if [ "$SHELLRC" == "" ]; then
	echo "source ~/.Sublivim/sublivimrc.sh" >> $SHELL_ACTIVE
	source $HOME/.Sublivim/sublivimrc.sh
fi

cd - > /dev/null
