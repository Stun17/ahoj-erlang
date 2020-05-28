-module (myapp).
-behaviour (application).
-export ([start/2, stop/1]).

start (_Type, _StartArgs) ->
  {ok, Port0} = application:get_env (port0),
  supervisor:start_link ({local, mysup}, mysup, [Port0]).

stop (_State) ->
  exit (whereis (mysup), shutdown).
