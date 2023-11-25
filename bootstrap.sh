#!/usr/bin/env bash

# go to scripts directory and then save working directory
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
olddir=~/.dotfiles_old
# list of files/folders to symlink in homedir
files=".aliases.d .bash_aliases .gitconfig .gitconfig.d .vimrc .vim"

##########

echo "Creating backup directory for any existing dotfiles in ~"
mkdir -vp $olddir
echo "...done"

echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving any existing dotfiles from ~ to $olddir and creating symlinks in home directory."
for file in $files; do
	mv -v ~/$file $olddir/$file 2>/dev/null
	ln -vs $dir/$file ~/$file
done

echo "...done"

SHELL_RC_FILE=~/.bashrc
if ! source $SHELL_RC_FILE; then
	. $SHELL_RC_FILE
fi
