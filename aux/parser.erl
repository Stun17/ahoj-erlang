-module (parser).
-export ([parse/1]).

parse (F) when is_list (F)   -> {ok, B} = file:read_file (F), parse (B);
parse (B) when is_binary (B) -> parse (B, [], [], []);
parse (_)                    -> io:fwrite ("argument must be either the filename or binary~n").

parse (<<$\r, Rest/binary>>, Field, Line, Acc) ->
  parse (Rest, Field, Line, Acc);
parse (<<$\n, Rest/binary>>, Field, Line, Acc) ->
  NewLine = [lists:reverse (Field) | Line],
  parse (Rest, [], [], [NewLine | Acc]);
parse (<<$\ , Rest/binary>>, Field, Line, Acc) ->
  parse (Rest, [], [lists:reverse (Field) | Line], Acc);
parse (<<Char, Rest/binary>>, Field, Line, Acc) ->
  parse (Rest, [Char | Field], Line, Acc);
parse (<<>>, [], [], Acc) ->
  {ok, lists:map (fun (X) -> lists:reverse (X) end, lists:reverse (Acc))};
parse (<<>>, Field, Line, Acc) ->
  parse (<<$\n>>, Field, Line, Acc).
