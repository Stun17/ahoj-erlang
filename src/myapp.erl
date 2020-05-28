-module (myapp).
-behaviour (application).
-export ([start/2, stop/1]).

start (_Type, _StartArgs) ->
  {ok, Port0} = application:get_env (port0),
  {ok, Port1} = application:get_env (port1),
  supervisor:start_link ({local, mysup}, mysup, [Port0,Port1]).

stop (_State) ->
  exit (whereis (mysup), shutdown).
