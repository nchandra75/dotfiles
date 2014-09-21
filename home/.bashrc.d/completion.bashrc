# Pull in completion modules -*- sh -*-

# system completion scripts
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

compdir='~/.bashrc.d/completion'
if [ -d $compdir ]; then
  for rc in $(find $compdir -maxdepth 1 -name '*.bash'); do
    source $rc
  done
fi

