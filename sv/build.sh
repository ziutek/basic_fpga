#!/bin/sh

set -e

# Options that can be customized using build.cfg
PROJ=
TOP=
PART=
SV=
V=
VHDL=
WDIR='build'
CONS='cons.ucf'
XST='-opt_mode area -opt_level 1'

. ./build.cfg

if [ $# -gt 0 ]; then
	case $1 in
		check)
			XST="$XST -compileonly yes"
		;;
		prog)
			xc3sprog -c bbv2_2 $WDIR/$PROJ.bit
			exit
		;;
		*)
			echo 'Usage: build.sh [check|prog]'
			exit
		;;
	esac
fi

if [ -z "$TOP" ]; then
	TOP=$PROJ
fi

mkdir -p $WDIR
rm -rf $WDIR/*

echo '+++++++++++        sv2v        +++++++++++'
echo

sv2v $SV >$WDIR/sv2.v

cd $WDIR

echo '+++++++++++        xst         +++++++++++'
echo

{
	echo "verilog work sv2.v"
	for f in $V; do
		echo "verilog work ../$f"
	done
	for f in $VHDL; do
		echo "vhdl work ../$f"
	done

} >$PROJ.prj

echo run -top $TOP $XST -p $PART -ifn $PROJ.prj -ifmt mixed -ofn $PROJ.ngc -ofmt NGC >$PROJ.xst

werr() {
	sed 's/"\(.*\)" Line \([0-9]\+\):/\1:\2:/g' \
		| awk 'BEGIN{r=0} IGNORECASE=1;/error:|warning:|failure:/{r=1}; END{exit(r)}'
}

xst -ifn $PROJ.xst |werr

if echo "$XST" | grep -q compileonly; then
	echo '+++++++++++ no errors/warnings +++++++++++'
	exit
fi

echo '+++++++++++      ngdbuild      +++++++++++'
echo

ngdbuild -p $PART -uc ../$CONS $PROJ

echo
echo '+++++++++++        map         +++++++++++'
echo

map -p $PART -mt 2 -w $PROJ

echo
echo '+++++++++++        par         +++++++++++'
echo

par -mt 4 -w $PROJ $PROJ

echo
echo '+++++++++++       bitgen       +++++++++++'
echo

bitgen -w $PROJ

echo
echo '+++++++++++        done        +++++++++++'
