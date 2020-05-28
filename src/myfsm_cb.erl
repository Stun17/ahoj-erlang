%%   new fashion style FSM
-module (myfsm_cb).
-behaviour (gen_statem).
-export ([ init/1, handle_info/3, terminate/3, code_change/4 ]).
-export ([ callback_mode/0, handle_event/4 ]).
-record (data, {attrib1, attrib2}).

callback_mode() -> handle_event_function.
init ([Val1, Val2]) -> {ok, stateOne, #data { attrib1 = Val1, attrib2 = Val2} } .

handle_event ({call, From}, transfer, State, #data { attrib1 = X, attrib2 = Y }) ->
  NewState = case State of 
               stateOne  -> X1 = X + 1, Y1 = Y     , stateTwo  ;  
               stateTwo  -> X1 = X,     Y1 = Y + 1 , stateThre ; 
               stateThre -> X1 = X - 2, Y1 = Y - 2 , stateOne  ;  
               true      -> X1 = X,     Y1 = Y     , State       
             end ,
  NewData = #data { attrib1 = X1, attrib2 = Y1 } ,
  {next_state, NewState, NewData, [ {reply, From, NewState} ]} ;

handle_event ({call, From}, getdata, _, Data) ->
  {keep_state, Data, [ {reply, From, Data} ]} ;

handle_event (_, _, _, Data) ->
  {keep_state, Data} .

handle_info (_, _, Data) -> {keep_state, Data} .
terminate (_, _, _) -> ok .
code_change (_OldVsn, State, Data, _Extra) -> {ok, State, Data} .
