while read x 
  do 
    echo $x | nc -u -w 1 localhost 33377 ; sleep 1 
  done <myinputfile
