-module (handler_02).
-behaviour (gen_event).
-export ([init/1, handle_event/2, handle_call/2, handle_info/2, terminate/2, code_change/3]).
-record (data, {attrib1, attrib2}).

init ([]) -> 
  {ok , #data {attrib1 = 10 , attrib2 = 20}}.

handle_event (_Event, State) -> 
  io:fwrite ("~p~n" , ["howdy from handler_02"]) ,
  {ok, State}.

handle_call (_Request, State) ->
  #data {attrib1 = X, attrib2 = Y} = State ,
  {ok, {X, Y}, State} .

handle_info (_Info, State) -> 
  {ok, State}.

terminate (_Reason, _State) -> 
  ok.

code_change (_OldVsn, State, _Extra) -> 
  {ok, State}.
