# Set an editor variable
if [ `whereis mvim` ]; then
	EDITOR=mvim
elif [ `whereis gvim` ]; then
	EDITOR=gvim
elif [ `whereis vim` ]; then
	EDITOR=vim
elif [ `whereis nano` ]; then
	EDITOR=nano
fi
export EDITOR
