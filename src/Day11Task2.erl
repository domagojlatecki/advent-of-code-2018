-module('Day11Task2').
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

larger1({X1, Y1, Power1}, {X2, Y2, Power2}) ->
    if
        Power1 > Power2 ->
            {X1, Y1, Power1};
        true ->
            {X2, Y2, Power2}
    end.

larger2({X1, Y1, S1, Power1}, {X2, Y2, S2, Power2}) ->
    if
        Power1 > Power2 ->
            {X1, Y1, S1, Power1};
        true ->
            {X2, Y2, S2, Power2}
    end.

getPowerValue(PowerLevels, I, J) ->
    Outer = array:get(I - 1, PowerLevels),
    array:get(J - 1, Outer).

colSum(X, Y, PowerLevels, Size) ->
    lists:sum([getPowerValue(PowerLevels, Row, Y) || Row <- lists:seq(X, X + Size)]).

rowSums(X, Y, LastY, PowerLevels, Size, ColToRemove, OldSum) ->
    if
        Y > LastY ->
            {0, 0, 0};
        Y > 1 ->
            MinusLast = OldSum - ColToRemove,
            FirstCol = colSum(X, Y, PowerLevels, Size),
            Sum = MinusLast + colSum(X, Y + Size, PowerLevels, Size),
            Next = rowSums(X, Y + 1, LastY, PowerLevels, Size, FirstCol, Sum),
            larger1({X, Y, Sum}, Next);
        true ->
            FirstCol = colSum(X, Y, PowerLevels, Size),
            Sum = lists:sum([colSum(X, Col, PowerLevels, Size) || Col <- lists:seq(Y, Y + Size)]),
            Next = rowSums(X, Y + 1, LastY, PowerLevels, Size, FirstCol, Sum),
            larger1({X, Y, Sum}, Next)
    end.

largestInRow(X, Size, PowerLevels) ->
    rowSums(X, 1, 300 - Size, PowerLevels, Size, 0, 0).

valueForSquare(Size, PowerLevels) ->
    {X, Y, Value} = lists:foldl(fun (L, R) -> larger1(L, R) end, {0, 0, 0}, [largestInRow(X, Size, PowerLevels) || X <- lists:seq(1, 300 - Size)]),

    if
        Value > 0 ->
            Next = valueForSquare(Size + 1, PowerLevels),
            larger2({X, Y, Size + 1, Value}, Next);
        true ->
            {0, 0, 0, 0}
    end.

main(Args) ->
    Input = lists:nth(1, Args),
    GridSerialNumber = list_to_integer(atom_to_list(Input)),
    PowerLevelsList = [[powerLevel(X, Y, GridSerialNumber) || Y <- lists:seq(1, 300)] || X <- lists:seq(1, 300)],
    PowerLevels = array:from_list(lists:map(fun (E) -> array:from_list(E) end, PowerLevelsList)),
    {X, Y, S, _} = valueForSquare(0, PowerLevels),
    io:format("~w,~w,~w~n", [X, Y, S]).
