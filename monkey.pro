%
%  Solve the monkey puzzle...
%
%  state will store:
%    Where's the monkey?
%    Where's the box?
%    What is the monkey standing on?
%    Does the monkey have the banana?
%
%  Start state: state(atDoor, atWindow, onFloor, hasNot)
%
%  End state: state(_, _, _, has)
%
transition(state(atMiddle, atMiddle, onBox, hasNot), 
           grasp, 
           state(atMiddle, atMiddle, onBox, has)).

transition(state(X, X, onFloor, B),
           climb,
           state(X, X, onBox, B)).

transition(state(X, X, onFloor, B),
           moveBox(X, Y),
           state(Y, Y, onFloor, B)).

transition(state(X, BoxLoc, onFloor, B),
           walk(X, Y),
           state(Y, BoxLoc, onFloor, B)) :-
  (nonvar(X), nonvar(Y), X \= Y) ;
  (nonvar(X), var(Y)) ;
  (var(X), nonvar(Y)).

%
%  This answer gives an infinite number of moves by allowing the monkey to
%  move the box from one arbitrary location to another, but it does give 
%  the shortest answer first.
%

canGet1(state(_, _, _, has)).
canGet1(CurrentState):-
  transition(CurrentState,_, NewState),
  canGet1(NewState).

canGet2(state(_, _, _, has), ActionList):-ActionList=[], !.
canGet2(CurrentState, ActionList):-
  transition(CurrentState, A, NewState),
  canGet2(NewState, Actions),
  ActionList = [A|Actions], !.  % A match with the second actio
                                  % cut off the option to backtrack

canGet(state(_, _, _, hatis), [gotBanana]).
canGet(CurrentState, ActionList) :-
  transition(CurrentState, Action, NewState),
  canGet(NewState, NextActions),
  ActionList = [Action | NextActions].


