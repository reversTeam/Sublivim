#!/bin/sh
SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"
HAS_ALIAS_SUBLIVIM=`cat $SHELL_ACTIVE | grep "#### ALIAS SUBLIVIM V.0 ####"`

if [ -d $HOME/.vim ] && [ -f $HOME/.vimrc ]; then
	echo "Sauvegarde de vos anciennes configuration Vim : ~/old-conf-vim.tar"
	(cd && tar -cf old-conf-vim.tar .vim .vimrc && rm -rf .vim .vimrc)
fi

echo "Installation du Sublivim"
tar -xf sv.tar && mv .vimrc ~/ && mv .vim ~/

if [ -z "$HAS_ALIAS_SUBLIVIM" ]; then
	echo "Téléchargement de norminator"
	chmod +x ~/.vim/shells/norminator
	~/.vim/shells/norminator --auth

	cat ~/.norminator | head -n 1 > ~/.norminator_bis
	cat ~/.norminator | tail -n 1 | cut -d ' ' -f -5 | tr -d '\n' >> ~/.norminator_bis
	echo " expires=\"4242-01-01 00:00:00Z\"; " | tr -d '\n' >> ~/.norminator_bis
	cat ~/.norminator | tail -n 1 | cut -d ' ' -f 8- >> ~/.norminator_bis
	mv ~/.norminator_bis ~/.norminator
	chmod 444 ~/.norminator

	echo "Ajout des commentaires nécessaire au bon fonctionnement du Sublivim"
	echo "#### ALIAS SUBLIVIM V.0 ####" >> ~/.zshrc
	echo 'alias emacs="vim"' >> ~/.zshrc
	echo 'alias vi="vim"' >> ~/.zshrc
	echo 'alias vim="vim -c NERDTreeToggle"' >> ~/.zshrc
	echo 'alias norminator="~/.vim/shells/norminator"' >> ~/.zshrc
	echo 'alias -s py="vim"' >> ~/.zshrc
	echo 'alias -s php="vim"' >> ~/.zshrc
	echo 'alias -s c="vim"' >> ~/.zshrc
	echo 'alias -s cpp="vim"' >> ~/.zshrc
	echo 'alias -s yml="vim"' >> ~/.zshrc
	echo 'alias -s js="vim"' >> ~/.zshrc
	echo 'alias -s css="vim"' >> ~/.zshrc
	echo 'alias -s scss="vim"' >> ~/.zshrc
	echo 'alias -s json="vim"' >> ~/.zshrc
	echo 'alias -s twig="vim"' >> ~/.zshrc
	echo 'alias -s html="vim"' >> ~/.zshrc
	echo "#### END ALIAS SUBLIVIM ####" >> ~/.zshrc
fi
