#if [ -e /tmp/test_sock.ipc ] ; 
#then rm /tmp/test_sock.ipc 
#fi

#### ncat -U /tmp/test_sock.ipc                  # Ctrl-z to pause , Ctrl-D to stop

#./sock2 & socat - UNIX-CLIENT:/tmp/test_sock.ipc 
#rm /tmp/test_sock.ipc 


# ncat -u localhost 33377

socat - udp-connect:127.0.0.1:33377
