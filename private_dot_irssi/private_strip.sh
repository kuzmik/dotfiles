# requires the irssi log2ansi.pl script in your path and mode 755
# get it from here: https://github.com/irssi/scripts.irssi.org/blob/master/scripts/log2ansi.pl

for i in ./logs/*/*.log
do
  cat $i | log2ansi.pl -clear > $i.tmp && mv $i.tmp $i
done
