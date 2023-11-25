#!/usr/bin/env bash

# save working directory
dir=$(pwd)
DATE=$(date +%Y%m%d%H%M%S)
olddir=~/.dotfiles_old/$DATE
# list of files/folders to symlink in homedir
files=".aliases.d .bash_aliases .gitconfig .gitconfig.d .vimrc .vim"

##########

mkdir -vp $olddir

echo "Changing to the $dir directory"
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving any existing dotfiles from ~ to $olddir and creating symlinks in home directory."
for file in $files; do
	mv -v ~/$file $olddir/$file 2>/dev/null
	ln -vs $dir/$file ~/$file
done

echo "...done"

SHELL_RC_FILE=~/.bashrc
if ! source $SHELL_RC_FILE 2>/dev/null; then
	. $SHELL_RC_FILE
fi
