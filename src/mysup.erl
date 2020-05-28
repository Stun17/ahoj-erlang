-module (mysup).
-behaviour (supervisor).
-export ([init/1]).

init ([Port0]) ->
  {ok, {{one_for_one, 5, 10},
          [ 
            {udp, {udpserv, start, [Port0]}, transient, 2000, worker, []}
          ]
       }
  } .
