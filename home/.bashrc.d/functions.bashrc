function c() {
	cd $HOME/work/current/$1
}

function psg() {
	ps -ef | grep $@
}

function cptar() {
	tar cvf - $1 | ( cd $2; tar xvf - )
}

