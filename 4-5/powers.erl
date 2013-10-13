-module(powers).
-export([raise/2,
         nth_root/2]).
-import(io, [format/2]).

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
