# Set an editor variable
if [ `which mvim` ]; then
	EDITOR=mvim
elif [ `which gvim` ]; then
	EDITOR=gvim
elif [ `which vim` ]; then
	EDITOR=vim
elif [ `which nano` ]; then
	EDITOR=nano
fi
export EDITOR
