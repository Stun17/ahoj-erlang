-module (myserver).
-export ([start/1, getm/2]).

start (RegName) ->
  gen_server:start_link ({local, RegName}, myserver_cb, [], []).

getm (RegName, [R1, R2, S]) ->
  case S of
    
    $+ -> 
      gen_server:call (RegName, {getit, 
                                 lists:concat (
                                   [ string:uppercase([R1,R2])
                                   , string:lowercase([$s])
                                   ]
                                  )
                                } 
                      ) ;
    $- -> 
      gen_server:call (RegName, {getit,
                                 lists:concat (
                                   [ string:uppercase([R1,R2])
                                   , string:lowercase([$u])
                                   ]
                                  )
                                }
                      );
    _   -> 
      gen_server:call (RegName, {getit, 
                                 lists:concat (
                                   [ string:uppercase([R1,R2])
                                   , string:lowercase([S])
                                   ]
                                  )
                                }
                      )
  end .
