#!/bin/sh

export anacad=/opt/mentor
source $anacad/com/init_anacad.ksh
export PATH=/opt/mentor:$PATH

echo "Mentor tools set up"
exec $SHELL
