# Modified .bash_profile
# Will try to load zsh if possible, else will continue with bash
# Nitin - 2014-09-22

#if [ -x "/usr/bin/zsh" ]; then
#	echo "zsh found. Loading that instead."
#	export SHELL=/bin/zsh
#	exec $SHELL -l
#fi;

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
