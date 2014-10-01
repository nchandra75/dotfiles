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

export PATH="/opt/bin:/usr/local/cuda/bin:$PATH"

# Source all scripts in ~/.bashrc.d ending with '.bashrc'
if [ -d ~/.bashrc.d ]; then
  for rc in $(find ~/.bashrc.d -maxdepth 1 -name '*.bashrc'); do
    source $rc
  done
fi

export ANDROIDSDK=/opt/android/adt/sdk
export ANDROIDNDK=/opt/android/ndk
export ANDROIDNDKVER=r9d
export ANDROIDAPI=19
export NDKROOT=$ANDROIDNDK
export PATH="$ANDROIDSDK/platform-tools:$ANDROIDSDK/tools:$ANDROIDNDK:$PATH"

# Homeshick not copied into the .bashrc.d - just left where it is
source $HOME/.homesick/repos/homeshick/homeshick.sh
