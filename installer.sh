#!/bin/sh
SV_VERSION="0"
SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"

HAS_ALIAS_SUBLIVIM=`cat $SHELL_ACTIVE | grep "#### ALIAS SUBLIVIM V.$SV_VERSION ####"`

git clone https://github.com/reversTeam/Sublivim.git
cd Sublivim

if [ -d $HOME/.vim ] && [ -f $HOME/.vimrc ]; then
	echo "Sauvegarde de vos anciennes configurations Vim : ~/old-conf-vim.tar"
	(cd && tar -cf old-conf-vim.tar .vim .vimrc && rm -rf .vim .vimrc)
fi

echo "Installation du Sublivim"
cp -p .vimrc ~/ && cp -Rp vim ~/.vim


if [ -z "$HAS_ALIAS_SUBLIVIM" ]; then
	echo "Ajout des commentaires nécessaire au bon fonctionnement du Sublivim"
	echo "#### ALIAS SUBLIVIM V.$SV_VERSION ####" >> ~/.zshrc
	echo 'alias emacs="vim"' >> ~/.zshrc
	echo 'alias vi="vim"' >> ~/.zshrc
	echo 'alias vim="vim -c NERDTreeToggle"' >> ~/.zshrc
	echo "#### END ALIAS SUBLIVIM ####" >> ~/.zshrc
fi

cd ../
rm -rf Sublivim
