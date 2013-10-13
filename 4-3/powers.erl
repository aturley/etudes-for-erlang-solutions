-module(powers).
-export([raise/2]).

raise(_, 0) ->
    1;
raise(X, 1) ->
    X;
raise(X, N) when N < 0 ->
    1.0 / raise(X, -N);
raise(X, N) ->
    X * raise(X, N-1).
