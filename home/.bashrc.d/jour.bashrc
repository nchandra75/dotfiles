# Some functions for taking notes

export JOUR_DIR=$HOME/Dropbox/notes

# open todays jour file
function jour-today () {
	d=`date +%y%m%d`
	today="$JOUR_DIR/$d.txt"
	$EDITOR $today
}
