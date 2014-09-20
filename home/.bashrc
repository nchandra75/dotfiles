# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# From /etc/skel/.bashrc -- Nitin
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If running interactively, then:
if [ "$PS1" ]; then
    # don't put duplicate lines in the history. See bash(1) for more options
    export HISTCONTROL=ignoredups

    # enable color support of ls and also add handy aliases
    if [ "$TERM" != "dumb" ]; then
	eval `dircolors -b`
	alias ls='ls --color=auto'
	#alias dir='ls --color=auto --format=vertical'
	#alias vdir='ls --color=auto --format=long'
    fi

    # some more ls aliases
    alias ll='ls -l'
    alias la='ls -A'
    #alias l='ls -CF'

    # Set up prompts. See http://www.linuxselfhelp.com/howtos/Bash-Prompt/Bash-Prompt-HOWTO-12.html
    SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
    if [ $SSH_IP ]; then
	    U="(\[\e[31m\]@ \h\[\e[30m\]) "
    fi
    if [ $USER != 'nitin' ]; then
	    U="(\[\e[36m\]\u\[\e[30m\]) $U"
    fi
    PS1="\[\e[1;30m\][\[\e[35m\]\d \t\[\e[30m\]] $U[\[\e[34m\]\W\[\e[30m\]]\[\e[32m\] \n\$\[\e[0m\] "
    case $TERM in
    xterm*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
    *)
        ;;
    esac

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc).
    if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
fi

export PATH="/opt/bin:/usr/local/cuda/bin:$PATH"

# Source all scripts in ~/.bashrc.d ending with '.bashrc'
if [ -d ~/.bashrc.d ]; then
  for rc in $(find ~/.bashrc.d -maxdepth 1 -name '*.bashrc' -type f); do
    source $rc
  done
fi

TODO_DIR=$HOME/work/admin/sync
if [ -f $TODO_DIR/todo.sh ]; then
	alias t="$TODO_DIR/todo.sh -d $TODO_DIR/todo.cfg"
	source $TODO_DIR/todo_completion
	complete -F _todo t
else
	alias t="echo 'todo.sh not installed.'"
fi

export ANDROIDSDK=/opt/android/adt/sdk
export ANDROIDNDK=/opt/android/ndk
export ANDROIDNDKVER=r9d
export ANDROIDAPI=19
export NDKROOT=$ANDROIDNDK
export PATH="$ANDROIDSDK/platform-tools:$ANDROIDSDK/tools:$ANDROIDNDK:$PATH"

source $HOME/.homesick/repos/homeshick/homeshick.sh

