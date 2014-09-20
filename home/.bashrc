# .bashrc
# User specific aliases and functions
# Split into multiple files in ~/.bashrc.d

# Source global definitions - assume this is minimal and required?
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Only urgent stuff required for non-interactive shells goes here.
# Other customizations go into separate files.
if [ -z "$PS1" ]; then
        return
fi

# All interactive shell stuff in separate files

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export PATH="/opt/bin:/usr/local/cuda/bin:$PATH"

# Source all scripts in ~/.bashrc.d ending with '.bashrc'
if [ -d ~/.bashrc.d ]; then
  for rc in $(find ~/.bashrc.d -maxdepth 1 -name '*.bashrc' -type f); do
    source $rc
  done
fi

export ANDROIDSDK=/opt/android/adt/sdk
export ANDROIDNDK=/opt/android/ndk
export ANDROIDNDKVER=r9d
export ANDROIDAPI=19
export NDKROOT=$ANDROIDNDK
export PATH="$ANDROIDSDK/platform-tools:$ANDROIDSDK/tools:$ANDROIDNDK:$PATH"

source $HOME/.homesick/repos/homeshick/homeshick.sh

