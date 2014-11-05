#!/bin/bash

#------------------------------------------------------------------------------
# Name:    scalasript
# Purpose: Creates SBT Runner script template
# Author:  Ernest Romero. http://unstable.build
# License: Creative Commons Attribution-ShareAlike 2.5 Generic
#          http://creativecommons.org/licenses/by-sa/2.5/
#------------------------------------------------------------------------------
declare -r TRUE=0
declare -r FALSE=1

# takes a string and returns true if it seems to represent "yes"
function isYes() {
  local x=$1
  [ $x = "y" ] && echo $TRUE; return
  [ $x = "Y" ] && echo $TRUE; return
  [ $x = "yes" ] && echo $TRUE; return
  [ $x = "YES" ] && echo $TRUE; return
  [ $x = "Yes" ] && echo $TRUE; return
echo $FALSE
}

echo "This creates a scala script in the current directory"

while [ $TRUE ]; do

  read -p "Define file name: " filename
  filename=${filename:-scalaScript}

  read -p "Create Script? (Y/n): " createScript
  createScript=${createScript:-y}
  [ "$(isYes $createScript)" = "$TRUE" ] && break

done

echo "#!/usr/bin/env scalas

/***
scalaVersion := \"2.11.4\"

libraryDependencies ++= Seq(
  \"ch.qos.logback\" % \"logback-classic\" % \"1.0.13\"
)
*/

import org.slf4j.LoggerFactory

val log = LoggerFactory.getLogger(\"Script\")

log.info(\"Hello World!\")" > ${filename}.scala

echo ""
echo "Script created! Executing for the first time..."

chmod u+x ${filename}.scala

${filename}.scala
