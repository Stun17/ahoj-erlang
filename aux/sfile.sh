while read x 
  do 
    echo -n $x " "
    echo $x | nc -u -w 1 localhost 33355 ; sleep 1 
  done <myinputfile
