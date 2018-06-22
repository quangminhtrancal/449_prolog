vegetable(fries).
vegetable(chips).

nut(peanut).
nut(almond).
nut(cashew).

junkfood(chips).
junkfood(candy).
junkfood(fries).


okForSchool(X) :- nut(X), !, fail.         % two options for fires but as long as i prove it is a nut then no back track
okForSchool(X) :- junkfood(X), !, fail.
okForSchool(_).