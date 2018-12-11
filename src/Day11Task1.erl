-module('Day11Task1').
-export([main/1]).

hunderedsDigit(Number) ->
    Div = Number div 100,
    abs(Div rem 10).

powerLevel(X, Y, GridSerialNumber) ->
    RackId = X + 10,
    PowerLevel = RackId * Y + GridSerialNumber,
    Mult = PowerLevel * RackId,
    Digit = hunderedsDigit(Mult),
    Digit - 5.

gridSum(X, Y, PowerLevels) ->
    X1 = lists:nth(X, PowerLevels),
    X1y1 = lists:nth(Y, X1),
    X1y2 = lists:nth(Y + 1, X1),
    X1y3 = lists:nth(Y + 2, X1),
    Sum1 = X1y1 + X1y2 + X1y3,
    X2 = lists:nth(X + 1, PowerLevels),
    X2y1 = lists:nth(Y, X2),
    X2y2 = lists:nth(Y + 1, X2),
    X2y3 = lists:nth(Y + 2, X2),
    Sum2 = X2y1 + X2y2 + X2y3,
    X3 = lists:nth(X + 2, PowerLevels),
    X3y1 = lists:nth(Y, X3),
    X3y2 = lists:nth(Y + 1, X3),
    X3y3 = lists:nth(Y + 2, X3),
    Sum3 = X3y1 + X3y2 + X3y3,
    {X, Y, Sum1 + Sum2 + Sum3}.

larger({X1, Y1, Power1}, {X2, Y2, Power2}) ->
    if
        Power1 > Power2 ->
            {X1, Y1, Power1};
        true ->
            {X2, Y2, Power2}
    end.

main(Args) ->
    Input = lists:nth(1, Args),
    GridSerialNumber = list_to_integer(atom_to_list(Input)),
    PowerLevels = [[powerLevel(X, Y, GridSerialNumber) || Y <- lists:seq(1, 300)] || X <- lists:seq(1, 300)],
    Sums = [[gridSum(X, Y, PowerLevels) || Y <- lists:seq(1, 298)] || X <- lists:seq(1, 298)],
    FlattenedSums = lists:flatten(Sums),
    {X, Y, _} = lists:foldl(fun (F, S) -> larger(F, S) end, {0, 0, 0}, FlattenedSums),
    io:format("~w,~w~n", [X, Y]).
