#!/bin/sh
SV_VERSION="0"
SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"
HAS_ALIAS_SUBLIVIM=`cat $SHELL_ACTIVE | grep "#### ALIAS SUBLIVIM V.$SV_VERSION ####"`

if [ -d $HOME/.vim ] && [ -f $HOME/.vimrc ]; then
	echo "Sauvegarde de vos anciennes configurations Vim : ~/old-conf-vim.tar"
	(cd && tar -cf old-conf-vim.tar .vim .vimrc && rm -rf .vim .vimrc)
fi

echo "Installation du Sublivim"
cp -p .vimrc ~/ && cp -Rp .vim ~/

echo "Connexion a Norminator"
~/.vim/shells/norminator --auth
cat ~/.norminator | head -n 1 > ~/.norminator_bis
cat ~/.norminator | tail -n 1 | cut -d ' ' -f -5 | tr -d '\n' >> ~/.norminator_bis
echo " expires=\"4242-01-01 00:00:00Z\"; " | tr -d '\n' >> ~/.norminator_bis
cat ~/.norminator | tail -n 1 | cut -d ' ' -f 8- >> ~/.norminator_bis
mv ~/.norminator_bis ~/.norminator
chmod 444 ~/.norminator

if [ -z "$HAS_ALIAS_SUBLIVIM" ]; then
	echo "Ajout des commentaires nécessaire au bon fonctionnement du Sublivim"
	echo "#### ALIAS SUBLIVIM V.$SV_VERSION ####" >> ~/.zshrc
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

vim ~/.vim/.msg_lockscreen
