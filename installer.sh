#!/bin/sh


echo "Sauvegarde de vos anciennes configuration Vim : ~/old-conf-vim.tar"
(cd && tar -cf old-conf-vim.tar .vim .vimrc && rm -rf .vim .vimrc)

echo "Installation du Sublivim"
tar -xf sv.tar && mv .vimrc ~/ && mv .vim ~/

echo "Téléchargement de norminator"
chmod +x ~/.vim/shells/norminator
~/.vim/shells/norminator --auth

cat ~/.norminator | head -n 1 > ~/.norminator_bis
cat ~/.norminator | tail -n 1 | cut -d ' ' -f -5 | tr -d '\n' >> ~/.norminator_bis
echo " expires=\"4242-01-01 00:00:00Z\"; " | tr -d '\n' >> ~/.norminator_bis
cat ~/.norminator | tail -n 1 | cut -d ' ' -f 8- >> ~/.norminator_bis
mv ~/.norminator_bis ~/.norminator
chmod 444 ~/.norminator
