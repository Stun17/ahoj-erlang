-module (tcpserv).
-export ([start/1, wait/1, work/2]).

start (Port) -> 
  {ok, ListenSocket} = gen_tcp:listen (Port, [binary, {active, false}]),
  {ok, spawn (?MODULE, wait, [ListenSocket])} .

wait (OldSocket) ->
  {ok, NewSocket} = gen_tcp:accept (OldSocket) ,
  Pid = spawn (?MODULE, work, [NewSocket, []]) ,
  gen_tcp:controlling_process (NewSocket, Pid),
  wait (OldSocket) .

work (Socket, BinaryList) ->
   case gen_tcp:recv (Socket, 0, 10000) of
     {ok, Binary} -> 
       ?MODULE:work (Socket, [BinaryList, Binary]) ;
     {error, closed} -> 
       {K,M,D} = erlang:timestamp() ,
       Name = lists:concat (["logs/", lists:map (fun integer_to_list/1, [K,M,D])]) ,
       file:write_file (Name, BinaryList) ;
     {error, timeout} -> 
       gen_tcp:close (Socket) ;
     _ -> ok 
   end.
