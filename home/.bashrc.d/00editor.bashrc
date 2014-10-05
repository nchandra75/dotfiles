# Set an editor variable
if [ -x `which mvim` ]; then
	EDITOR=mvim
elif [ -x `which gvim` ]; then
	EDITOR=gvim
elif [ -x `which vim` ]; then
	EDITOR=vim
elif [ -x `which nano` ]; then
	EDITOR=nano
fi
export EDITOR
