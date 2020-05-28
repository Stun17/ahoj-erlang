-module (udpserv) .
-behaviour (gen_server).
-export ([start/1]) .
-export ([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start (MyPort) ->
  gen_server:start_link ({local, ?MODULE}, ?MODULE, [MyPort], []) .

init ([MyPort]) ->
  {ok, Socket} = gen_udp:open (MyPort, [list]) ,
  {ok, {Socket, MyPort, mysrv1}} . 

handle_info ({udp, Socket, HisAddr, HisPort, [A,B,C|_]}, {Socket, MyPort, Serv}) ->
  Qwt = lists:concat ([string:uppercase ([A,B]), string:lowercase ([C])]) ,
  Ans = myserver:getm (Serv, Qwt) ,
  gen_udp:send (Socket, HisAddr, HisPort, io_lib:format ("~.2f  ~.2f~n", Ans)) ,
  gen_udp:close (Socket) ,
  {ok, NewSocket} = gen_udp:open (MyPort, [list]) ,
  NewServ = if Serv == mysrv1 -> mysrv2; true -> mysrv1 end ,
  {noreply, {NewSocket, MyPort, NewServ}} .

terminate   (_Reason, {Socket,_,_})    -> gen_udp:close (Socket) , ok .
handle_call (_Req, _From, State)       -> {reply, ok, State} .
handle_cast (_Req, State)              -> {noreply, State} .
code_change (_OldVsn, State, _Extra)   -> {ok, State} .
