%
%  Determine the solutions for the three line puzzle for a given set of
%  12 unique integers.
%
%

%
%  Nums will be instantiated to a list of 12 unique integers
%
%  Line1, Line2 and Line3 will be uninstantiated variables that are each
%  instantiated to a list of 5 integers.
%
%  Total will be an uninstantiated variable that will be instantiated to 
%  the total that is common to Line1, Line2, and Line 3.
solve(Nums, Line1, Line2, Line3, Total) :-
  % Pick the values for the end points of the three lines
  member(X, Nums),
  member(Y, Nums),
  member(Z, Nums),

  % Prevent generating answers that are just a rotation of each other
  X < Y,
  X < Z,
  Y < Z,
  % The above task could also be performed using sublist in a manner similar
  % to picking the groups of 3 numbers needed for the lines.

  % Remove X, Y and Z from the candidates that are still remaining
  subtract(Nums, [X, Y, Z], NumbersForLines),

  % Select 3 numbers for line 1
  sublist([A1, A2, A3], NumbersForLines),

  % Select 3 numbers for line 2
  subtract(NumbersForLines, [A1, A2, A3], NumbersForLines23),
  sublist([B1, B2, B3], NumbersForLines23),

  % Select 3 numbers for line 3
  subtract(NumbersForLines23, [B1, B2, B3], [C1, C2, C3]),

  % Instantiate the variables for the lines that were provided as parameters
  Line1 = [Z, A1, A2, A3, X],
  Line2 = [X, B1, B2, B3, Y],
  Line3 = [Z, C1, C2, C3, Y],

  % Do the lines total to the same value?
  Total is Z + A1 + A2 + A3 + X,
  Total =:= X + B1 + B2 + B3 + Y,
  Total =:= Z + C1 + C2 + C3 + Y.

