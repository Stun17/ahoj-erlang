-module (mysup).
-behaviour (supervisor).
-export ([init/1]).

init ([Port0]) ->
  {ok, {{one_for_one, 5, 10},
          [ {ms1, {myserver, start, [mysrv1]}, permanent, 2000, worker, [myserver_cb]}
          , {ms2, {myserver, start, [mysrv2]}, permanent, 2000, worker, [myserver_cb]}
          , {mf1, {myfsm, start, [myfsm1]}, permanent, 2000, worker, [myfsm_cb]}
          , {mf2, {myfsm, start, [myfsm2]}, permanent, 2000, worker, [myfsm_cb]}
          , {udp, {udpserv, start, [Port0]}, transient, 2000, worker, []}
          ]
       }
  } .
