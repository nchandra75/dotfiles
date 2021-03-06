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

# Source all scripts in ~/.bashrc.d ending with '.bashrc'
if [ -d ~/.bashrc.d ]; then
  for rc in $(find ~/.bashrc.d -maxdepth 1 -name '*.bashrc'); do
    source $rc
  done
fi

# Add ~/bin to path always
export PATH=$HOME/bin:$HOME/.local/bin:$PATH
# Homeshick not copied into the .bashrc.d - just left where it is
source $HOME/.homesick/repos/homeshick/homeshick.sh


#PATH="/home/nitin/perl5/bin${PATH:+:${PATH}}"; export PATH;
#PERL5LIB="/home/nitin/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/nitin/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/nitin/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/nitin/perl5"; export PERL_MM_OPT;
