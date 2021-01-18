#!/bin/bash
 
 ## It's always easier to create back up - restore scripts with Tar or zip format and transferring to another server using scp/rsync/ssh
 ## Embeding binaries to bash - uuencode is peobably an appropriate approach
 ## Trying to implement CAT EOF solution as per the task demands - written on a windows system, couldn't test :(
 
 ## This script expects a source and a destination path. When run, reads the source file and restores in dest.
 path=$1
 dest=$2
 
 if [ $# -ne 2 ];
 echo "Usage : $0 <source path> <destination path>
 cd $path
 
 chrbin() {
         echo $(printf \\$(echo "ibase=2; obase=8; $1" | bc))
 }
 
 ordbin() {
   a=$(printf '%d' "'$1")
   echo "obase=2; $a" | bc >>$2
 }
 
 ascii2bin() {
     cat $1 | while IFS= read -r -n1 char
     do
         ordbin $char | tr -d '\n'
         echo -n " "
     done
 }
 
 bin2ascii() {
     while read bin
     do
         chrbin $bin | tr -d '\n'
     done <$1
 }
 
 
 for i in `ls`; do
 type=`file -I $i | awk -F'=' '{print $2}'`
 out=$dest/${i}_bkup
 
 if [ "$type" == "us-ascii" ]; then
 here=`cat $i`
 (
 cat <<EOF
 $here
 EOF
 ) >$out
 fi
 
 if [[ "$type" == "binary" ]]; then
 here=`bin2ascii $i`
 cat <<EOF
 $here
 EOF
 ) >temp.txt
 
 ascii2bin temp.txt $out
 fi
 
 done
