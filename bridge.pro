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

% state: What's on the left; what's on the right
% start state: state(a,b,c,d,light],[])
% end state: state([],[_, _, _, _, _])

%Transition that moves two people ( and the flashlight) from the left side of the ravine
% to the right side of the ravine

% Transition that moves one person ( and the flashlight) from the right side f the ravine to the left side of the ravine

transition1(OldState, Action, NewState) :-
    OldState = state(OldLeft, OldRight),
    member(P1, OldLeft),
    member(P2, OldLeft), 
    P1 @< P2,  % previously P1 \= P2; now implicitly say P1 @< P2; compare character to characters
    P1 \= light,
    P2 \= light,
    member(light, OldLeft),   % 6 different restrictions
    % action
    Action = walkover(P1, P2, light).

    % state
    subtract(OldLeft, [P1, P2, light], NewLeft),
    NewRight = [P1, P2, light | OldRight],
    NewState = state(NewLeft, NewRight),

% TRansition from right to left
transition1(OldState, Action, NewState) :-
    OldState = state(OldLeft, OldRight),
    member(P, OldRight),
    P \= light,
    member(light, OldRight),
    Action = walkBack(P, light),
    NewLeft = [P, light | OldLeft],
    subtract(OldRight, [P, light], NewRight),
    NewState = state(NewLeft, NewRight).

% solve the puzzle
solve1(state([],[_, _, _, _])).
solve1(CurrentState) :- 
  transition1(CurrentState, _, NewState),
  solve1(NewState).


%%%%%%%%%%%%5 Done the basic

% solve the puzzle
solve2(state([],[_, _, _, _]), []). % action list
solve2(CurrentState, Actions) :- 
  transition1(CurrentState, A, NewState),
  solve2(NewState, NewActions),
  Actions = [A| NewActions].











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

  time(P1, TimeP1),     %get the longer time
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

% findall(..., solve(state([a,b,c,d,light],[])Action, Time), Result).
% % findall(Action, solve(state([a,b,c,d,light],[])Action, Time), Result).
% % findall(Time, solve(state([a,b,c,d,light],[])Action, Time), Result).
% % findall(Action, solve(state([a,b,c,d,light],[])Action, Time), Result),min_list(AllTimes, MinTime).

% % findall(ans(Action,Time), solve(state([a,b,c,d,light],[])Action, Time), Result), min_list(Result, MinTime).

% % findall(ans(Action,Time), solve(state([a,b,c,d,light],[])Action, Time), Result), min_list(Result, MinTime),findall(A,solve(),Action, Mintime,Result).

bestAnswer(State, B) :- 
findall(Time, solve(State), _, Time), TimeList),
min_list(TimeList, MinTime),
findall(A, solve(State, A, MinTime), Best),
member(B, Best).

bestAnswer1(State, ans(B, MinTime)) :- 
    findall(Time, solve(State), _, Time), TimeList),
    min_list(TimeList, MinTime),
    findall(A, solve(State, A, MinTime), Best),
    member(B, Best).

% Display the answers with a nicer layout.
%
writeAnswers(Best) :-
  Best = [H | Tail],
  H = result(Time, Actions),
  write(Time), write(' minutes using '), write(Actions), nl,
  writeAnswers(Tail).
