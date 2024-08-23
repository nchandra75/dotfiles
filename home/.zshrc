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

# linuxbrew has some of the executables in the path
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

bashd=$HOME/.bashrc.d
# Use the same aliases etc from Bash
source $bashd/00alias.bashrc

# Completion etc loaded at end
zshd=$HOME/.zsh.d
source $zshd/completion

# Set up cd path
setopt auto_cd
cdpath=($HOME $HOME/work $HOME/work/current $HOME/git $HOME/scratch)

# brew install fzf 
source <(fzf --zsh)
# clone https://github.com/Aloxaf/fzf-tab - not adding into homeshick
fzftab=$HOME/.local/zsh-local/fzf-tab
[ -f $fzftab/fzf-tab.plugin.zsh ] && source $fzftab/fzf-tab.plugin.zsh

# . $HOME/.asdf/asdf.sh
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"

