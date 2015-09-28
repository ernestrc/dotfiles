#!/bin/bash

#------------------------------------------------------------------------------
# Name:    sbtproject
# Purpose: Create an SBT project directory structure and optionally starts main/test classes
# Author:  Alvin Alexander, http://alvinalexander.com.
#          Modified by Ernest Romero, http://unstable.build
# License: Creative Commons Attribution-ShareAlike 2.5 Generic
#          http://creativecommons.org/licenses/by-sa/2.5/
# Gist:    https://gist.github.com/ernestrc/a0b132ca54efb38c2479
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

echo "This script creates an SBT project directory beneath the current directory."

while [ $TRUE ]; do
  echo ""
  read -p "Directory/Project Name (MyFirstProject): " directoryName
  directoryName=${directoryName:-MyFirstProject}

  read -p "Create .gitignore File? (Y/n): " createGitignore
  createGitignore=${createGitignore:-y}

  read -p "Create README.md File? (Y/n): " createReadme
  createReadme=${createReadme:-y}

  read -p "Create test and main classes? (Y/n): " createClasses
  createClasses=${createGitignore:-y}

  echo ""
  echo "-----------------------------------------------"
  echo "Directory/Project Name: $directoryName"
  echo "Create .gitignore File?: $createGitignore"
  echo "Create README.md File?: $createReadme"
  echo "Create test and main classes?: $createClasses"
  echo "-----------------------------------------------"
  read -p "Create Project? (Y/n): " createProject
  createProject=${createProject:-y}
  [ "$(isYes $createProject)" = "$TRUE" ] && break
done

# directoryName

mkdir -p ${directoryName}/src/{main,test}/{resources,scala}
mkdir ${directoryName}/lib ${directoryName}/project ${directoryName}/target

# optional
#mkdir -p ${directoryName}/src/main/config
#mkdir -p ${directoryName}/src/{main,test}/{filters,assembly}
#mkdir -p ${directoryName}/src/site

#---------------------------------
# create an initial build.sbt file
#---------------------------------
echo "name := \"$directoryName\"

version := \"0.1\"

scalaVersion := \"2.11.4\"

sbtVersion := \"0.13.5\"

libraryDependencies ++= List(
  \"com.h2database\"              % \"h2\"                    % \"1.3.173\"     % \"test\",
  \"org.hamcrest\"                % \"hamcrest-all\"          % \"1.3\"         % \"test\",
  \"org.scalacheck\"             %% \"scalacheck\"            % \"1.11.3\"      % \"test\",
  \"junit\"                       % \"junit\"                 % \"4.7\"         % \"test\",
  \"org.specs2\"                 %% \"specs2\"                % \"2.4\"         % \"test\",
  \"org.mockito\"                 % \"mockito-all\"           % \"1.9.0\"       % \"test\",
  \"com.novocode\"                % \"junit-interface\"       % \"0.7\"         % \"test->default\"
)

scalacOptions ++= Seq(
  \"-unchecked\",
  \"-deprecation\",
  \"-Xlint\",
  \"-Ywarn-dead-code\",
  \"-language:_\",
  \"-target:jvm-1.6\",
  \"-encoding\", \"UTF-8\"
)

resolvers ++= Seq(
  \"Typesafe Repository\"       at        \"http://repo.typesafe.com/typesafe/releases/\",
  \"Sonatype Snapshots\"        at        \"http://oss.sonatype.org/content/repositories/snapshots\",
  \"Sonatype Releases\"         at        \"http://oss.sonatype.org/content/repositories/releases\",
  \"Spray Repo\"                at        \"http://repo.spray.io\",
  \"Spray Nightlies\"           at        \"http://nightlies.spray.io\"
)


parallelExecution in Test := false

testOptions in Test += Tests.Argument(TestFrameworks.Specs2, \"junitxml\", \"console\")" > ${directoryName}/build.sbt

echo "resolvers += \"Sonatype snapshots\" at \"https://oss.sonatype.org/content/repositories/snapshots/\"

addSbtPlugin(\"com.github.mpeltonen\" % \"sbt-idea\" % \"1.7.0-SNAPSHOT\")
" > ${directoryName}/project/plugins.sbt

if [ "$(isYes $createClasses)" = "$TRUE" ]; then
  echo "object Main extends App {
    println(\"Hello World!\")
  }" > ${directoryName}/src/main/scala/Main.scala
fi

if [ "$(isYes $createClasses)" = "$TRUE" ]; then
  echo "import org.specs2.mock.Mockito
  import org.specs2.mutable.SpecificationLike

  class Mainspec extends SpecificationLike with Mockito {
      \"Main\" should {
        \"Do something\" in {
          success
        }
      }
  }" > ${directoryName}/src/test/scala/Mainspec.scala
fi

if [ "$(isYes $createGitignore)" = "$TRUE" ]; then
echo "bin/
project/
target/
.cache
.idea
.classpath
.project
.settings" > ${directoryName}/.gitignore
fi

#-----------------------------
# create README.me, if desired
#-----------------------------
if [ "$(isYes $createReadme)" = "$TRUE" ]; then
touch ${directoryName}/README.md
fi

echo ""
echo "Project created! Starting sbt..."
echo ""

cd ${directoryName} && sbt
