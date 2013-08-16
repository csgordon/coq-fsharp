#!/bin/bash

DIRNAME=`dirname $1`
BASENAME=`basename $1 .ml`
FILE="${DIRNAME}/${BASENAME}.fs"
OUT="${DIRNAME}/${BASENAME}.dll"

touch $FILE
echo module ${BASENAME} > $FILE
echo >> $FILE
echo open Coq >> $FILE
echo >> $FILE
cat $1 | sed -e 's/ assert / ml_assert /g' \
       | sed -e 's/^/  /' >> $FILE
fsharpc --mlcompatibility -a -r:Coq.dll $FILE -o:$OUT
