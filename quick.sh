#! /run/current-system/sw/bin/bash

case $1 in
  "start" ) echo -n "starting app ... " 
            erl -pa ebin -eval "application:start(myapp)" -noshell -detached ;
            sleep 3 ;
            echo " done!"                        ;;
  "stop"  ) echo -n "stopping app ... " 
            declare -a ans                       ;
            ans=( $( ps aux | grep [m]yapp ) )   ;
            kill -15 ${ans[1]}                   ;
            echo " done!"                        ;;
  *       ) echo "usage : ./quick.sh start|stop" ;;
esac
