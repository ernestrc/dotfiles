#!/usr/bin/env bash
 
DOCKER=`which docker`
 
usage()
{
echo "Usage: $(basename $0) [-l num] IMAGE"
exit 0
}
 
if [ "$#" -lt 1 ]; then
usage
exit 0
fi
 
l="-1"
while getopts ":l:" opt;
do
case "$opt" in
l)
l=$OPTARG
;;
esac
done
shift $((OPTIND-1))
 
for commit in $($DOCKER history $1 | sed 1d | awk '{ print $1 }')
do
if [ $l -eq 0 ]; then
exit 0
elif [ $l -gt 0 ]; then
l=$((l - 1))
fi
content="$commit
$($DOCKER inspect $commit | tr -d '\"' | grep 'Created\|Author\|Comment')"
echo "$content"
done 
