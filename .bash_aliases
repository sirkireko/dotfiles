
ALIASES_PATH=~/.aliases.d
if [ -d $ALIASES_PATH ]; then
	for file in $(find -L $ALIASES_PATH); do
		if [ -f "$file" ]; then
    			source $file
		fi
	done
fi
