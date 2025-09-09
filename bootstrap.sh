#!/usr/bin/env bash

# save working directory
dir=$(pwd)
DATE=$(date +%Y%m%d%H%M%S)
olddir=~/.dotfiles_old/$DATE
# list of files/folders to symlink in homedir
files=".aliases.d .bash_aliases .gitconfig .gitconfig.d .vimrc .vim"
OLD_NEEDED=0
for file in $files; do
	OLD_NEEDED=$(expr $OLD_NEEDED + $(ls ~/$file 2>/dev/null | wc -l))
done

##########
if [ "$OLD_NEEDED" -gt 0 ]; then
	mkdir -vp $olddir
fi

echo "Changing to the $dir directory"
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
if [ "$OLD_NEEDED" -gt 0 ]; then
	echo "Moving any existing dotfiles from ~ to $olddir and"
fi
echo "Creating symlinks in home directory."
for file in $files; do
	if [ "$OLD_NEEDED" -gt 0 ]; then
		mv -v ~/$file $olddir/$file 2>/dev/null
	fi
	ln -vs $dir/$file ~/$file
done

echo "...done"

SHELL_RC_FILE=~/.bashrc
if ! source $SHELL_RC_FILE 2>/dev/null; then
	. $SHELL_RC_FILE
fi
