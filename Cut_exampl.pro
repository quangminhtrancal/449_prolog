red(apple).
red(ruby).

orange(carrot).
orange(pumpkin).
orange(orange).

green(celery).
green(emerald).
green(leaf).
green(green_bean).

color(x, red):-red(X), !.
color(X, orange):-orange(X), !.
color(X, green):-green(X), !.
color(X, unknown).


color1(x, red):-red(X).
color1(X, orange):-orange(X).
color1(X, green):-green(X).
color1(X, unknown):- \+red(X), \+orange(X), \+green(X).