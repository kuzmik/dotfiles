OLDPWD=`pwd`

for i in $(ls -d /Users/nick/Code/*); do 
  MAIN=$(git main-branch)
  cd $i; 
  echo "    Cleaning $i"; 
  git com; 
  git pull;
  git prune; 
  git branch --merged $MAIN | egrep -v $MAIN$ | xargs git branch -d; 
  git gc --aggressive; 
  unset $MAIN
done; 

cd $OLDPWD
