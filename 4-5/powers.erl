-module(powers).
-export([raise/2,
         nth_root/2]).
-import(io, [format/2]).
-import(lists, [concat/1, map/2, seq/2]).
-include_lib("eunit/include/eunit.hrl").

raise(X, 1, Acc) ->
    X * Acc;
raise(X, N, Acc) ->
    raise(X, N - 1, X * Acc).

-spec(raise(number(), integer()) -> number()).
raise(_, 0) ->
    1;
raise(X, N) when N < 0 ->
    1.0 / raise(X, -N);
raise(X, N) ->
    raise(X, N, 1).

nth_root(X, N, A) ->
    io:format("Current guess is ~f~n", [A]),
    F = raise(A, N) - X,
    Fprime = N * raise(A, N - 1),
    Next = A - F / Fprime,
    Change = abs(Next - A),
    if Change < 1.0e-8 ->
            Next;
       true ->
            nth_root(X, N, Next)
    end.

-spec(nth_root(number(), integer()) -> number()).
nth_root(X, N) ->
    nth_root(X, N, X / 2.0).


%% tests

raise_test_() ->
    [
     ?_assertEqual(raise(0, 0), 1),
     ?_assertEqual(raise(1, 0), 1),
     ?_assertEqual(raise(2, 0), 1),
     ?_assertEqual(raise(0, 1), 0),
     ?_assertEqual(raise(0, 2), 0),
     ?_assertEqual(raise(0, 10000), 0),
     ?_assertEqual(raise(1, 1), 1),
     ?_assertEqual(raise(1, 2), 1),
     ?_assertEqual(raise(1, 10000), 1),
     ?_assertEqual(raise(2, 1), 2),
     ?_assertEqual(raise(2, 2), 4),
     ?_assertEqual(raise(2, 3), 8),
     ?_assertEqual(raise(3, 4), 81),
     ?_assertEqual(raise(3.0, 4), 81.0),
     ?_assertEqual(raise(0.5, 0), 1),
     ?_assertEqual(raise(0.5, 1), 0.5),
     ?_assertEqual(raise(0.5, 2), 0.25),
     ?_assertEqual(raise(2, -1), 0.5),
     ?_assertEqual(raise(2, -2), 0.25),
     ?_assertEqual(raise(2, -2), raise(1.0 / 2, 2))
    ].

nth_root_test_() ->
    [
     ?_assertEqual(nth_root(0, 1), 0.0),
     ?_assertEqual(nth_root(1, 1), 1.0),
     ?_assertEqual(nth_root(2, 1), 2.0),
     ?_assertEqual(nth_root(4, 2), 2.0),
     ?_assertEqual(nth_root(9, 2), 3.0),
     ?_assertEqual(nth_root(81, 4), 3.0)
    ].

qc_prop(B, E) ->
    ?_assertEqual(1.0 * B, nth_root(raise(B, E), E)).

qc_test_() ->
    qc_test_gen(100).

qc_test_gen(N) ->
    {generator,
     fun () -> 
             if N > 0 ->
                     map(fun (E) -> qc_prop(N, E) end, seq(1, 7)) ++
                         qc_test_gen(N - 1);
                true ->
                     []
                end
     end}.
