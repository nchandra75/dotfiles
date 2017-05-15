# Prompt setup for bash -*- sh -*-
# Set up prompts. See http://www.linuxselfhelp.com/howtos/Bash-Prompt/Bash-Prompt-HOWTO-12.html

# From https://github.com/cowboy/dotfiles/blob/master/source/50_prompt.sh
if [[ ! "${prompt_colors[@]}" ]]; then
prompt_colors=(
		"36" # information color
		"37" # bracket color
		"31" # error color
	      )

if [[ "$SSH_TTY" ]]; then
# connected via ssh
prompt_colors[0]="32"
elif [[ "$USER" == "root" ]]; then
#           # logged in as root
prompt_colors[0]="35"
fi
fi

#                 # Inside a prompt function, run this alias to setup local $c0-$c9 color vars.
alias prompt_getcolors='prompt_colors[9]=; local i; for i in ${!prompt_colors[@]}; do local c$i="\[\e[0;${prompt_colors[$i]}m\]"; done'


function prompt_exitcode() {
	prompt_getcolors
	[[ $1 != 0 ]] && echo " $c2$1$c9"
}


SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
if [ $SSH_IP ]; then
U="\e[0;31m@ (\h)\e[m "
fi
if [ $USER != 'nitin' ]; then
U="\e[1;36m(\u)\e[m $U"
fi

# Git status.
function prompt_git() {
	prompt_getcolors
	local status output flags branch
	status="$(git status 2>/dev/null)"
	[[ $? != 0 ]] && return;
	output="$(echo "$status" | awk '/# Initial commit/ {print "(init)"}')"
	[[ "$output" ]] || output="$(echo "$status" | awk '/# On branch/ {print $4}')"
	[[ "$output" ]] || output="$(git branch | perl -ne '/^\* \(detached from (.*)\)$/ ? print "($1)" : /^\* (.*)/ && print $1')"
	flags="$(
		echo "$status" | awk 'BEGIN {r=""} \
		/^# Changes to be committed:$/        {r=r "+"}\
		/^# Changes not staged for commit:$/  {r=r "!"}\
		/^# Untracked files:$/                {r=r "?"}\
		END {print r}'
	)"
	if [[ "$flags" ]]; then
		output="$output$c1:$c0$flags"
	fi
	echo "$c1<git: $c0$output$c1>$c9 "
}

# Determine active Python virtualenv details.
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="(`basename \"$VIRTUAL_ENV\"`) "
  fi
}

function prompt_command() {
	local exit_code=$?
	# If the first command in the stack is prompt_command, no command was run.
	# Set exit_code to 0 and reset the stack.
	[[ "${prompt_stack[0]}" == "prompt_command" ]] && exit_code=0
	prompt_stack=()

	# Manually load z here, after $? is checked, to keep $? from being clobbered.
	[[ "$(type -t _z)" ]] && _z --add "$(pwd -P 2>/dev/null)" 2>/dev/null
	#
	# While the simple_prompt environment var is set, disable the awesome prompt.
	[[ "$simple_prompt" ]] && PS1='\n$ ' && return

	prompt_getcolors
	set_virtualenv    # set up the venv information
        # http://twitter.com/cowboy/status/150254030654939137
	PS1="\n"
        # git: [branch:flags]
	PS1="$PS1$PYTHON_VIRTUALENV$(prompt_git)"
	# path: [user@host:path]
	PS1="$PS1$c1["
	if [ $USER == "root" ]; then
		PS1="$PS1$c2 ROOT "
	else 
		PS1="$PS1$c0\u"
	fi
	PS1="$PS1$c1@$c0\h$c1:$c0\w$c1]$c9"
	PS1="$PS1\n"
        # date: [HH:MM:SS]
	PS1="$PS1$c1[$c0$(date +"%F %H:%M:%S")$c1]$c9"
        # exit code: 127
	PS1="$PS1$(prompt_exitcode "$exit_code")"
	PS1="$PS1 \\$ "
}
# Note: assumes that git-prompt.sh has already been sourced.  
# In my setup, this is in 01git-prompt.bashrc
# <$?> not working properly below:
# PS1="$U \e[0;36m[\w]\e[0;33m\$(__git_ps1 \" (%s)\")\e[0;30m\e[0;32m \n\e[0;35m\d \t\e[0;31m <\$?> \e[1;36m\\$\e[m "
# PS1="$U \e[0;36m[\w]\e[0;33m\$(__git_ps1 \" (%s)\")\e[0;30m\e[0;32m \n\e[0;35m\d \t\e[0;31m \e[1;36m\\$\e[m "

# Remove the check for xterm here.  Why was it needed?
#case $TERM in
#xterm*)
# PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
PROMPT_COMMAND="prompt_command"
#;;
#*)
#;;
#esac

# Setting language here?
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
