# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/oh-my-zsh
ZSH_THEME=""

#WORDPRESS_BLOG
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="wordpress28"
DB_HOST="ernestrc-wordpressblog.cx47mu0a0z8l.eu-west-1.rds.amazonaws.com"
DB_CHARSET="utf8"
DB_COLLATE=""
AUTH_KEY=""
SECURE_AUTH_KEY=""
LOGGED_IN_KEY=""
NONCE_KEY=
AUTH_SALT=
SECURE_AUTH_SALT=
NONCE_SALT=

#JAVA HOME
if [ -d "/usr/lib/jvm/jre-1.7.0-openjdk.x86_64/bin/java" ]; then
    export JAVA_HOME="/usr/lib/jvm/jre-1.7.0-openjdk.x86_64/bin/java"
    $JAVA_HOME/bin/java -version
else
    if [ -d "/usr/lib/jvm/java-6-openjdk-amd64/jre" ]; then
        export JAVA_HOME="/usr/lib/jvm/java-6-openjdk-amd64/jre"
        $JAVA_HOME/bin/java -version
    else
        if [ -d "/usr/lib/jvm/java-7-openjdk-amd64/jre" ]; then
            export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre"
            $JAVA_HOME/bin/java -version
        else
            if [ -d "/usr/libexec/java_home" ]; then
                export JAVA_HOME=$(/usr/libexec/java_home)
                $JAVA_HOME/bin/java -version
            else
                echo "Couldn't find JAVA_HOME"
            fi
        fi
    fi
fi

export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.7.3.2
export EC2_URL=https://ec2.eu-west-1.amazonaws.com
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:/usr/lib:$JAVA_HOME/jre/lib/amd64/server/:$LD_LIBRARY_PATH

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

#CAPTURE LAST COMMANDS OUTPUT
PROMPT_COMMAND='LAST="`cat /tmp/x`"; exec >/dev/tty; exec > >(tee /tmp/x)'

if [[ -z ${MY_SHELL_LEVEL} ]]; then
  export MY_SHELL_LEVEL=0
else
  export MY_SHELL_LEVEL=$(($MY_SHELL_LEVEL+1))
fi

export SS_DISPLAY_LIMIT=25
export ZSH_CUSTOM=~/.dotfiles/zsh_custom
plugins=(git regex-dirstack vim-interaction)
source $ZSH/oh-my-zsh.sh
source $ZSH/themes/ernestrc-plus.zsh-theme

bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
setopt auto_pushd
setopt pushd_silent
setopt pushd_ignore_dups
setopt ignore_eof
setopt rm_star_silent
unsetopt nomatch
unsetopt correct_all

export PATH=.:~/bin:~/local/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/Users/ernestrc/dev/scala/play/:$EC2_HOME/bin:/usr/local/mysql/bin:~/bin/sbt:~/dev/Amazon/AWS-ElasticBeanstalk-CLI-2.6.4/eb/macosx/python2.7/:/opt/local/bin:$HOME/dev/chromium/depot_tools:/usr/local/share/npm/bin:$HOME/etcd-v0.4.6-darwin-amd64

export GPGKEY=B2F6D883
export GPG_TTY=$(tty)

export PYTHONSTARTUP=$HOME/.pythonrc.py

export CONSCRIPT_OPTS="-XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -Xmx3G -XX:MaxPermSize=1G -Duser.timezone=UTC"

export EDITOR=vim

if which dircolors > /dev/null; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto -F'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

function dockerlog #https://gist.github.com/yarcowang/370e63e68972afbff970
{
    $HOME/.dotfiles/dockerlog.sh $@
}

function mongocsv
{
    $HOME/.dotfiles/mongocsv
}

function dockerClean
{
    docker rm $(docker ps -a -q)
    docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
}

function replesent
{
    $HOME/.dotfiles/replesent.sh $1
}

function eecho
{
  echo $@ 1>&2
}

function dotfiles
{
    bash $HOME/.dotfiles/backup.sh
}

function devblog
{
    clear
    cd $HOME/dev/projects/wordpress
    git status
}

function lbe {
    python $HOME/tokbox/longboard/src/utils/bootstrapReport.py
}

function tb
{
    cd $HOME/tokbox
    ls -l
}

function deveng
{
    clear
    cd $HOME/dev/projects/unstable-engine
    git status
    sbt
}

bindkey "^A" beginning-of-line

bindkey "^E" end-of-line

function dev
{
    cd $HOME/dev/projects/
    ls -l
}

function sbtproject
{
    $HOME/.dotfiles/sbtproject.sh
}

function scalascript
{
    $HOME/.dotfiles/scalascript.sh
}

function scalatron {
    cd ~/dev/scala/scalatron_bots
    git add --all .
    git commit -m "pushed through script"
    git push
}

function mkgo {

mkdir $1 && cd $1

}

function pyclean {
find . | grep -E "(__pycache__|\.pyc$)" | xargs rm -rf
}

function pythonp
{
    declare -r TRUE = 0
    declare -r FALSE = 1

    while [ 1 ]; do
    read -p "Define file name: " filename
    filename = ${filename:-python_module}
    done

    echo """#!/usr/bin/env python

import sys

def main(argv):
    hello = \"Hello World!\"
    for arg in argv:
        hello = hello + \" \" + arg
    print hello


if __name__ == \"__main__\":
    main(sys.argv[1:])
""" >> ${filename}.py
echo ""
echo "Created python module" + $filename + ".py"
chmod u+x ${filename}.py
${filename}.py
}

function swift
{
    xcrun swift -sdk /Applications/Xcode.app/Contents/Develope//Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk
}

function findWithSpec
{
  local dirs=
  local egrepopts="-v '\\.sw[po]\\$|/\\.git/|^\\.git/|/\\.svn/|^\\.svn/'"
  local nullprint=
  while [[ $# != 0 ]];
  do
    if [[ "$1" == "-Z" ]]; then
      egrepopts="-Zz $egrepopts"
      nullprint="-print0"
      shift
    elif [[ -d "$1" ]]; then
      dirs="$dirs '$1'"
      shift
    else
      break
    fi
  done
  if [[ -z "$dirs" ]]; then
    dirs=.
  fi
  eval "find $dirs $nullprint $@ | egrep $egrepopts"
}

function findsrc
{
  findWithSpec "$@" '-name \*.java -o -name \*.scala -o -name Makefile -o -name \*.h -o -name \*.cpp -o -name \*.c'
}
alias findsrcz="findsrc -Z"

function findj
{
  findWithSpec "$@" '-name \*.java'
}
alias findjz="findj -Z"

function finds
{
  findWithSpec "$@" '-name \*.scala'
}
alias findsz="finds -Z"

function findsj
{
  (finds "$@"; findj "$@")
}
alias findsjz="findsj -Z"

function findh
{
  findWithSpec "$@" '-name \*.h -o -name \*.hpp'
}
alias findhz="findh -Z"

function findc
{
  findWithSpec "$@" '-name \*.cpp -o -name \*.c'
}
alias findcz="findc -Z"

function findch
{
  (findc "$@"; findh "$@")
}
alias findchz="findch -Z"

function findpy
{
  findWithSpec "$@" '-name \*.py'
}
alias findcpy="findpy -Z"

function findf
{
  findWithSpec "$@" "-type f"
}
alias findfz="findf -Z"

function findm
{
  findWithSpec "$@" "-name Makefile"
}
alias findmz="findm -Z"

function findpom
{
  findWithSpec "$@" "-name pom.xml"
}
alias findpomz="findpom -Z"

function findx
{
  findWithSpec "$@" "-name \*.xml"
}
alias findxz="findx -Z"

function findd
{
  findWithSpec "$@" "-type d"
}
alias finddz="findd -Z"

function findExtension
{
  local ext=
  local dir=.
  if [[ $# == 0 ]]; then
    echo "usage: findExtension [dir] <extension>"
    return 1
  else
    ext=$@[$#]
    if [[ $# != 1 ]]; then
      dir=$1
    fi
  fi
  findWithSpec $dir '-name \*'.$ext
}
alias fe=findExtension

alias f=findWithSpec

function findClass
{
  local pattern="${1-}"
  if [ -z "$pattern" ]; then
    eecho "No pattern supplied" 1>&2
    return 1
  fi
  echo $CLASSPATH | tr ':' '\n' | grep -v '^ *$' | \
    while read entry
    do
      echo "====== $entry ======"
      if [ "${entry%.jar}" != "$entry" ]; then
        if [ -f "$entry" ]; then
          jar tf "$entry" | egrep $pattern
        fi
      elif [ -d "$entry" ]; then
        find "$entry" | egrep -i $pattern
      fi
    done
}

function ff
{
  if [ $# = 0 ]; then
    eecho "usage: ff <file>" 1>&2
    return 1
  fi
  if [ -d "$1" ]; then
    eecho "That's a directory, dumbass." 1>&2
    return 1
  elif [ "${1%/*}" = "$1" ]; then
    firefox -new-tab "file://$(pwd)/$1"
  else
    "cd" "${1%/*}"
    local dir="$(pwd)"
    "cd" - >/dev/null
    firefox -new-tab "file://$dir/${1##*/}"
  fi
  return 0
}

function gitall
{
  find . -type d -a -name .git | while read d
  do
    local x=${d%.git}
    echo ========= $x
    (cd $x; git "$@")
  done
}

#custom aliases
alias scalass='scalascript'
alias sbtp='sbtproject'


# Assorted
alias swps='find . -name .\*.sw[op]'
alias rmstd='xargs rm -vf'
alias xag='xargs -0 egrep'
alias xg='xargs egrep'
alias xgi='xargs egrep -i'
alias pd="cd -"
alias grss='for f in $(find . -type d -a -name .git); do x=${f%/.git}; echo ==== $x; (cd $x; gss); done'
alias gd='git diff'
alias gdc='git diff --cached'
alias o=octave

alias sc=screen
alias scl="screen -list"

alias pgrep="pgrep -fl"

alias bc="bc -lq"

test -f ~/.zshrc_local && . ~/.zshrc_local

# Auvik Settings
export JAVA_OPTS="-XX:ReservedCodeCacheSize=128m -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=1024m -Xmx1024m -Xss2m -XX:+UseCodeCacheFlushing"

alias kb="kubectl"
alias toktok2="gcloud compute ssh toktok2"
alias toktok1="gcloud compute ssh toktok1"
alias toktok-db="gcloud compute ssh toktok-database"
alias toktok-master="gcloud compute ssh toktok-master"

alias xclip="xclip -selection c"
alias lbemailer="python /Users/ernest/tokbox/longboard/src/emailer/emailer.py"

#GREETING

echo "
    ______                     __  ____  ______
   / ____/________  ___  _____/ /_/ __ \/ ____/
  / __/ / ___/ __ \/ _ \/ ___/ __/ /_/ / /
 / /___/ /  / / / /  __(__  ) /_/ _, _/ /___
/_____/_/  /_/ /_/\___/____/\__/_/ |_|\____/
"

# etcd endpoint
export ETCD_ENDPOINT="127.0.0.1:4001"

# Kitematic
export DOCKER_HOST=tcp://192.168.99.100:2376 
export DOCKER_CERT_PATH=/Users/ernest/.docker/machine/machines/dev 
export DOCKER_TLS_VERIFY=1

source $HOME/.bashrc
