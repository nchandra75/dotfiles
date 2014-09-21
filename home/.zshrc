# Set up the prompt

autoload -Uz promptinit
promptinit
prompt clint

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history


# Nitin 
source $HOME/.homesick/repos/homeshick/homeshick.sh
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

bashd=$HOME/.bashrc.d
# Use the same aliases etc from Bash
source $bashd/00alias.bashrc

# Completion etc loaded at end
zshd=$HOME/.zsh.d
source $zshd/completion
