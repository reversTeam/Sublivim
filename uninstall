#!/bin/sh

SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"

cd ~
rm -rf .vimrc
rm -rf .vim
rm -rf .Sublivim

if [ -f "$HOME/old-conf-vim.tar" ]; then
	tar -xf old-conf-vim.tar
fi

cat $SHELL_ACTIVE | grep -v ".Sublivim/sublivimrc.sh" > "${SHELL_ACTIVE}_tmp"
mv "${SHELL_ACTIVE}_tmp" "${SHELL_ACTIVE}"

cd - > /dev/null 2> /dev/null
