#!/bin/bash

STR="export HISTCONTROL=some value export []"

STR="export STR=some value export []"


VAR=${STR#export }
VAR=${VAR%%=*}

echo "=========="
echo $HISTCONTROL
echo $VAR
echo $STR
echo "${!VAR}"

if [ -z "${!VAR}" ]; then
             #VAR is unset, add to the file
             echo "Variable is unset"
else
     echo "$VAR is set to '${!VAR}', would you like to add '$STR' (N to skip)?";
     read yn
     if [ "$yn" != "N" ]; then
           echo "SET"
     fi
fi

exec bash
