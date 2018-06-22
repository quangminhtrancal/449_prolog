nFib(0, 0) :- !.
nFib(1, 1) :- !.
nFib(N, Result) :- 
    Y is N-1,
    X is N-2,
    nFib(Y, ResultY),
    nFib(X, ResultX),
    Result is ResultY + ResultX.

nFib1(0, 0).
nFib1(1, 1).
nFib1(N, Result) :- 
    N > 1,
    Y is N-1,
    X is N-2,
    nFib1(Y, ResultY),
    nFib1(X, ResultX),
    Result is ResultY + ResultX.