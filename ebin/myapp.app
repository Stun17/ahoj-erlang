{ application, myapp, 
  [
        { description,  "my otp pokerth applic"},
        { vsn,          "0.1.0"},
        { applications, [stdlib, kernel]},
        { modules,      [ myapp , mysup
                        , myserver, myserver_cb
                        , myfsm, myfsm_cb 
                        , myevent, handler_02, handler_01
                        , udpserv, tcpserv
                        ]},
        { registered,   [mysup, mysrv1, mysrv2, myfsm1, myfsm2, myevnt]},
        { env,          [ {port0, 33355}
                        , {port1, 33378}
                        ]},
        { mod,          {myapp, []}}
  ] 
} .
