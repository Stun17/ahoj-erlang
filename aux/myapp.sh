case $1 in
  "start" ) 
        /home/nomad/.local/bin/myapp -pa ebin -eval "application:start(sasl), application:start(myapp)" -noshell -detached ;;
  "stop" ) 
      declare -a ans ;
      ans=(`ps aux | grep '[b]in/target'`) ;
      if [ -z $ans ] ; then echo "not found" ; else kill -15 ${ans[1]} ; fi ;;
   * ) 
     echo "usage: myapp.sh start|stop" ;;
esac  
