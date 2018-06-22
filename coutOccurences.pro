countOccurences(_, [], 0). % Base case
countOccurences(X, List, Count):- 
    List = [Head| Tail],
    X = Head,                   % if the first is not instantiated then the X get the head; 
    countOccurences(X, Tail, TailCout),    
    Count is TailCout +1.  % force to do calculation

countOccurences(X, List, Count):-
    List = [Head| Tail],
    X \= Head,
    countOccurences(X, Tail, Count).