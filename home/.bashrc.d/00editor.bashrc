# Set an editor variable
if [ `command -v mvim` ]; then
	EDITOR=mvim
elif [ `command -v gvim` ]; then
	EDITOR=gvim
elif [ `command -v vim` ]; then
	EDITOR=vim
elif [ `command -v nano` ]; then
	EDITOR=nano
else
	# Ran out of options. Set a default and hope for the best.
	EDITOR=vi
fi
export EDITOR
