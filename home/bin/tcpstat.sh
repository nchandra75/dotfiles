sudo /usr/sbin/tcpdump -i $1 -n -v -tt  | awk 'BEGIN {t=0;s=0;n=0} {n++; if (t==0) {t=$1; s=int($17);} else { s=s+int($17); } if ( ($1-t)>=1 ) { print "Time:",($1-t),"n=",n,"avg=",s/n,"bps=",8*s/($1-t); t=$1; s=0;n=0;}}'