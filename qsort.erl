-module(qsort).
-export([read/1]).

read(File) ->
    {ok, Bin} = file:read_file(File),
    BinL = binary:split(Bin, [<<"\n">>], [global]),
    L = [binary_to_list(X) || X <- BinL],
    K = lists:reverse(L),
    M = tl(K),
    B = to_tuple(M),
    O = quicksort(B),
    io:format("~p~n",[O]).

to_tuple([]) ->
    [];
to_tuple(L) ->
    to_tuple(L, []).
to_tuple([], Acc) ->
    Acc;
to_tuple([H|T], Acc) ->
    {A, B} = list_to_tuple(string:tokens(H, " ")),
    {Int, Rest} = string:to_integer(A),
    D = {Int,B},
    to_tuple(T, [D|Acc]).

quicksort([]) ->
    [];
quicksort([Pivot|T]) ->
    quicksort([X || X <- T, X < Pivot])
    ++ [Pivot] ++
    quicksort([X || X <- T, X >= Pivot]).
