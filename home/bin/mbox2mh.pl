#!/usr/local/bin/perl --	-*- Perl -*-
#
# mbox2mh - #
# by Miurasoft

# minimum customization
$homedir=$ENV{'HOME'};
$profile='.mh_profile';
$mbox='mbox';		

# option switches
$debug=0;			# debug message
$notout=0;			# not to make any file

# global variables
$topdir="Mail";		
$folder="inbox";	
$msgcnt=0;		

require 'getopts.pl';

&Getopts('hdnf:');
if (defined($opt_h)) { print <<END_HELP;
name:     mbox2mh
function: copy messages from mbox(UNIX Mail file) into MH folder
usage:    mbox2mh [options] FILE
          FILE: UNIX Mail file
options:  -h        : this help
          -d        : debug mode
          -n        : do not make file
          -f FOLDER : MH folder name
END_HELP
    exit(0);
}
if (defined($opt_d)) { $debug=1; }
if (defined($opt_n)) { $notout=1; }
if (defined($opt_f)) { $folder=$opt_f; }

($debug) && print "reading profile...\n";
open(PROF, "$homedir/$profile") ||
    die("profile '$homedir/$profile' not found\n");
while (<PROF>) {
    ($debug) && print;
    chop;
    if (/^path:\s*(\S+)/io) {
	$topdir=$1;
	if ($topdir !~ /^\//o) {
	    $topdir="$homedir/$topdir";
	}
	($debug) && print "topdir=$topdir\n";
    }
}
close(PROF);

$msgcnt=0;
opendir(FOLDER, "$topdir/$folder") || 
    die ("folder $topdir/$folder cannot open\n");
while ($name=readdir(FOLDER)) {
    $name =~ s/^\#//o;
    if (($name =~ /^\d+$/o) && 
	($msgcnt<$name)) {	
	$msgcnt=$name+0;	
	($debug) && print "existing message count $msgcnt\n";
    }
}
closedir(FOLDER);
++$msgcnt;

if (!$notout) {
    open(MOUT, ">$topdir/$folder/$msgcnt") ||
	die("cannot make $topdir/$folder/$msgcnt");
}
($debug) && print "output to $topdir/$folder/$msgcnt\n";
if ($b=<ARGV>) {
    ($debug) && print $b;
    if (!$notout) {
	print MOUT $b;
    }
}
while ($b=<ARGV>) {
    if ($b =~ /^From /io) {
	if (!$notout) {
	    close(MOUT);
	}
	++$msgcnt;
	if (!$notout) {
	    open(MOUT, ">$topdir/$folder/$msgcnt") ||
		die("cannot make $topdir/$folder/$msgcnt");
	}
	($debug) && print "output to $topdir/$folder/$msgcnt\n";
	($debug) && print $b;
    }
    if (!$notout) {
	print MOUT $b;
    }
}
if (!$notout) {
    close(MOUT);
}

($debug) && print "completed.\n";

0;
