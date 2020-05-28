-module (myfsm).
-export ([start/1, stop/1, getdata/1, trans/1]).

start (FsmName) ->
  gen_statem:start_link ({local, FsmName}, myfsm_cb, [17, 42], []).

stop(FsmName) ->
  gen_statem:stop (FsmName).

getdata (FsmName) ->
  gen_statem:call (FsmName, getdata).

trans (FsmName) ->
  gen_statem:call (FsmName, transfer).
