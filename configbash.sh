#!/bin/bash

TARGETFILE=$HOME/.bashrc

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

        # we need to check if the settings already have different value        
  	    if [[ $configline == "export *" ]]; then
                # this is variable string in the config, pars the variable
                VAR=${confitline#export} # remove word export
                VAR=${VAR%%=*} # remove everything after
                if [ -z "${!VAR}" ]; then 
                        #VAR is unset, add to the file
                		echo $configline >> $TARGETFILE
                else 
                        echo "$VAR is set to '${!VAR}', would you like to add '$configline' (n to skip)?"; 
                        read yn
                        if [ $yn == "n" ]; then
                                continue
                        else
        		                echo $configline >> $TARGETFILEi
                        fi
                fi
        else # this is setting, not a variable        		
        		echo $configline >> $TARGETFILE
        fi
	fi
done<bash.config


echo "Would you like to add DISPLAY=localhost:0.0 (N to skip)?"; 
read yn
[ "$yn" != "n" ] && cat bashdisplay.config >> $TARGETFILE


echo "Would you like to add custom bash promt (N to skip)?"; 
read yn
[ "$yn" != "n" ] && cat bashpromt.config >> $TARGETFILE

# execute bashrc
exec bash
