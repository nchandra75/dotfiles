# Prompt setup for bash -*- sh -*-
# Set up prompts. See http://www.linuxselfhelp.com/howtos/Bash-Prompt/Bash-Prompt-HOWTO-12.html
SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
if [ $SSH_IP ]; then
	U="(\[\e[31m\]@ \h\[\e[30m\]) "
fi
#if [ $USER != 'nitin' ]; then
	U="(\[\e[36m\]\u\[\e[30m\]) $U"
#fi

# Note: assumes that git-prompt.sh has already been sourced.  
# In my setup, this is in 01git-prompt.bashrc

PS1='\[\e[1;31m\]\u@\h \[\e[30m\][\[\e[34m\]\w\[\e[33m\]$(__git_ps1 " (%s)")\[\e[30m\]]\[\e[32m\] \n\[\e[30m\]\[\e[35m\]\d \t\[\e[31m\] \$\[\e[0m\] '

case $TERM in
    xterm*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
    *)
        ;;
esac

