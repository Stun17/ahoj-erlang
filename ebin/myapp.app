{ application, myapp, 
  [
        { description,  "my otp pokerth applic"},
        { vsn,          "0.1.0"},
        { applications, [stdlib, kernel]},
        { modules,      [ myapp , mysup
                        , myserver, myserver_cb
                        , myfsm, myfsm_cb 
                        , udpserv
                        ]},
        { registered,   [mysup, mysrv1, mysrv2, myfsm1, myfsm2]},
        { env,          [ {port0, 33355} ]},
        { mod,          {myapp, []}}
  ] 
} .
