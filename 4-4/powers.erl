-module(powers).
-export([raise/2]).

raise(X, 1, Acc) ->
    X * Acc;
raise(X, N, Acc) ->
    raise(X, N - 1, X * Acc).

raise(_, 0) ->
    1;
raise(X, N) when N < 0 ->
    1.0 / raise(X, -N);
raise(X, N) ->
    raise(X, N, 1).
