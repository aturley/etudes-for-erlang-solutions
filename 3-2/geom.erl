-module(geom).
-export([area/3]).
-import(math,[pi/0]).

area(rectangle, A, B) when A >= 0, B >= 0 ->
    A * B;
area(triangle, A, B) when A >= 0, B >= 0 ->
    A * B / 2.0;
area(ellipse, A, B) when A >= 0, B >= 0 ->
    math:pi() * A * B.
