#!/bin/bash
set -o errtrace
set -o errexit
set -o nounset
set -o pipefail

# depends on the gitaliases defined in `~/.gitconfig`, specifically `main-branch` and `com`
# This is a huge work in progress, as i get the motivation/inclination
# can and will get messy if you have any dirty files, but such is life.
# Could do git stash in dirty repos, idk.

OLDPWD=`pwd`

for i in $(ls -d /Users/nick/Code/*); do
  MAIN=$(git main-branch)
  cd $i;
  echo "\n\033[1m=> Pulling $i...\033[0m\n"
  git com > /dev/null 2>&1;
  git pull;
  git prune; 
  for b in $(git branch --merged $MAIN | egrep -v $MAIN$); do
    git branch -d $b
    echo "\n\033[1m => Deleted merged branch $b\033[0m\n"
  done
  git gc --aggressive; 
  unset $MAIN
done; 

cd $OLDPWD
