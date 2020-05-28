-module (myserver_cb).
-behaviour (gen_server).
-export ([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

init (_Args) ->
  {ok, ERef10} = ets:file2tab ("priv/ten-hands.ets") ,
  {ok, ERef02} = ets:file2tab ("priv/two-hands.ets") ,
  {ok, [ERef10,ERef02]} .

handle_call ({getit, [A,B,C|_]}, _From, [ERef10,ERef02]) ->
  Ans = case ets:lookup (ERef10, [A,B,C]) of
          [{_,X}] -> 
            case ets:lookup (ERef02, [A,B,C]) of
              [{_,Y}] -> [X, Y] ;
              _       -> [] 
            end ;
          _  -> 
            case ets:lookup (ERef10, [B,A,C]) of
              [{_,X}] -> 
                case ets:lookup (ERef02, [B,A,C]) of
                  [{_,Y}] -> [X,Y] ;
                  _       -> [] 
                end 
            end
        end ,
  {reply,  Ans, [ERef10, ERef02]} ;

handle_call (_Req, _From, State) ->
  {reply, smth_wrong, State} .

handle_cast (_Req, State)             ->   {noreply, State} .
handle_info (_Info, State)            ->   {noreply, State} .
terminate (_Reason, _State)           ->   ok .
code_change (_OldVsn, State, _Extra)  ->   {ok, State} .
