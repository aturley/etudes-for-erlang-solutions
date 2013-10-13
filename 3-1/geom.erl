-module(geom).
-export([area/3]).
-import(math,[pi/0]).

area(rectangle, A, B) ->
    A * B;
area(triangle, A, B) ->
    A * B / 2.0;
area(ellipse, A, B) ->
    math:pi() * A * B.
