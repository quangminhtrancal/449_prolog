%
%  Figure out how to move people from one side of a ravine to the other.
%
%  A maximum of two people are allowed to cross the bridge at the same time.
%  A person / 2 people can only cross the bridge if they have the light.
%
%  What is the minimum time needed to get everyone across?  What sequence
%  of actions gives the minimum result?
%

time(a, 1).
time(b, 2).
time(c, 5).
time(d, 10).

%
%  state(WhatsOnTheLeft, WhatsOnTheRight).
%
%  Start state: state([a, b, c, d, light], [])
%
%  End state: state([], [a, b, c, d, light])
%

% Walk two people from left to right
transition(OldState, Action, ActionTime, NewState) :-
  OldState = state(OldLeft, OldRight),
  member(light, OldLeft),
  member(P1, OldLeft),
  member(P2, OldLeft),
  P1 \= P2,
  P1 \= light,
  P2 \= light,
  P1 @< P2,

  time(P1, TimeP1),
  time(P2, TimeP2),
  max_list([TimeP1, TimeP2], ActionTime),

  subtract(OldLeft, [P1, P2, light], NewLeft),
  NewRight = [P1, P2, light | OldRight],
  NewState = state(NewLeft, NewRight),
  Action = walkacross(P1, P2, light).

% Walk one person back from right to left
transition(OldState, Action, ActionTime, NewState) :-
  OldState = state(OldLeft, OldRight),
  member(light, OldRight),
  member(P, OldRight),
  P \= light,

  time(P, ActionTime),

  subtract(OldRight, [P, light], NewRight),
  NewLeft = [P, light | OldLeft],
  NewState = state(NewLeft, NewRight),
  Action = walkback(P, light).


% Solve the puzzle
solve(state([], [_, _, _, _, _]), 0, []).
solve(CurrentState, Time, Actions) :-
  transition(CurrentState, TransitionAction, TransitionTime, NewState),
  solve(NewState, RemainingTime, RemainingActions),
  Time is TransitionTime + RemainingTime,
  Actions = [TransitionAction | RemainingActions].

%
% Find the best answers.  bestAnswer should be called with Best being
% an uninstantiated variable.
%
bestAnswers(Best) :-
  % Find the minimum time
  findall(Time, solve(state([a, b, c, d, light], []), Time, _), AllTimes),
  min_list(AllTimes, MinTime),

  % Find all of the results that execute in minumum time
  findall(result(MinTime, Actions), 
          solve(state([a, b, c, d, light], []), MinTime, Actions), 
          Best).

%
% Display the answers with a nicer layout.
%
writeAnswers(Best) :-
  Best = [H | Tail],
  H = result(Time, Actions),
  write(Time), write(' minutes using '), write(Actions), nl,
  writeAnswers(Tail).
