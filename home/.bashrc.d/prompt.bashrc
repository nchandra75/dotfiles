# Prompt setup for bash -*- sh -*-
# Set up prompts. See http://www.linuxselfhelp.com/howtos/Bash-Prompt/Bash-Prompt-HOWTO-12.html

SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
if [ $SSH_IP ]; then
	U="\e[0;31m@ (\h)\e[m "
fi
if [ $USER != 'nitin' ]; then
	U="\e[1;36m(\u)\e[m $U"
fi

# Note: assumes that git-prompt.sh has already been sourced.  
# In my setup, this is in 01git-prompt.bashrc
# <$?> not working properly below:
PS1="$U \e[0;36m[\w]\e[0;33m\$(__git_ps1 \" (%s)\")\e[0;30m\e[0;32m \n\e[0;35m\d \t\e[0;31m <\$?> \e[1;36m\\$\e[m "

case $TERM in
    xterm*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
    *)
        ;;
esac

