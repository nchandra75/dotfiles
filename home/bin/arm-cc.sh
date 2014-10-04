#!/bin/bash
# Set up env variables and path for cross-compiling kernel for Beagleboard.
# Nitin - 20100331

export CROSS_COMPILE=arm-none-linux-gnueabi-
export ARCH=arm
export PATH=$PATH:/opt/codesourcery/bin
exec $SHELL
