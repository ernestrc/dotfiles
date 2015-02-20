#!/bin/bash

REPLesent=$HOME/dev/scala/replesent/replesent.scala
MSG="[REPLesent] -"

if [ $# -eq 0 ]
  then
    echo "$MSG You need to supply the presentation file name as an argument!"
    echo ""
    echo "usage: $0 [yourpresentation.txt]"
    exit 1;
fi

# Check that input is not absolute or relative path
if [[ $1 == *"/"* ]]
    then
        echo "$MSG You can't use a relative or absolute path to locate the presentation!"
        echo "$MSG Move first to the presentation directory and then call REPLesent from there."
        exit 1;
fi

# Check that file exists in WD
if [ ! -f $PWD/$1 ]
    then
        echo "$MSG No such file $1 in $PWD"
        exit 1;
fi

id=$RANDOM-$RANDOM
tmpfile="/tmp/$1-$id.scala"

echo "val replesent = REPLesent(input=\"$1\", intp=\$intp);import replesent._;f;" >> $tmpfile

echo -e "$MSG Starting presentation $1...\n"

scala -Dscala.color -language:_ -nowarn -i $REPLesent -i $tmpfile
