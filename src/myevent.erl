-module (myevent).
-export ([start/0, stop/0]).

start () -> 
  {ok, Pid} = gen_event:start_link ({local , myevnt}) ,
  gen_event:add_handler (myevnt, handler_01, []) ,
  gen_event:add_handler (myevnt, handler_02, []) ,
  {ok, Pid} .

stop () -> 
  gen_event:stop (myevnt).
