#!/bin/bash

TARGETFILE=$HOME/.vimrc

# create file if not exist
[ ! -f $TARGETFILE ] && touch $TARGETFILE || echo "$TARGETFILE Found"


# read data from the file
while read -r configline ; do
	#trim line
	line="${configline##*( )}"
	line="${configline%%*( )}"
	# skip empty lines
	[ -z "$configline" ] && continue
	# skip comments
	[[ ${configline:0:1} == "#" ]] && continue

	# now we search the config file
	if grep -q "$configline" $TARGETFILE ; then
		echo "Settings [$configline] already exist. Skip."
	else
		echo $configline >> $TARGETFILE
	fi

done<vim.config
