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

##
# Your previous /Users/nitin/.bash_profile file was backed up as /Users/nitin/.bash_profile.macports-saved_2015-10-25_at_18:43:54
##

# MacPorts Installer addition on 2015-10-25_at_18:43:54: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

