-module(core).
-export([future/1, f/0]).

f() ->
    timer:sleep(20000),
    "My result.".

future(F) ->
    Res = F(),
    receive
        dereference ->
            io:format("~s~n", [Res]);
        _ ->
            io:format("Invalid command.~n")
    end.

% 1> c(core).
% {ok,core}
% 2> P = spawn(core, future, [fun core:f/0]).
% <0.39.0>
% 3> P ! dereference.
% dereference
% 4> % Waiting...
% My result.

