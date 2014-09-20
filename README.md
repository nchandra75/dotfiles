dotfiles
========

Configuration setup for my Linux machines. This uses the homeshick script: https://github.com/andsens/homeshick
Most of the configuration is copied from various sources. Attributed where possible, or where I remember the source. 

Howto
=====

On a new machine:
  git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick

followed by 
  printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc

then open a new =bash= prompt, and run
  homeshick clone nchandra75/dotfiles

Go open source!
