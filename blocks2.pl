% on(X,Y) means that block X is directly on top of block Y.
on(b1,b2).   on(b3,b4).   on(b4,b5).   on(b5,b6).

% just left(X,Y) means that blocks X and Y are on the table
% and that X is immediately to the left of Y.
just_left(b2,b6).   just_left(b6,b7).

% above(X,Y) means that block X is somewhere above block Y 
% in the pile where Y occurs.
above(X,Y) :- on(X,Y).
above(X,Y) :- on(X,Z), above(Z,Y).

% left(X,Y) means that block X is somewhere to the left 
% of block Y but perhaps higher or lower than Y.
% left(X,Y) :- just_left(X,Y).
% left(X,Y) :- just_left(X,Z), left(Z,Y).
% left(X,Y) :- on(X,Z), left(Z,Y).     % leftmost is on something.
% left(X,Y) :- on(Y,Z), left(X,Z).     % rightmost is on something.

left(X,Y)  :-  bottom(X,X1),  bottom(Y,Y1),  table_left(X1,Y1). 

bottom(X,X)  :-  \+  on(X,Y).	%  Note  the  use  of  \+  !
bottom(X,X1)  :-  on(X,Y),  bottom(Y,X1).

table_left(X,Z)  :-  just_left(X,Z).
table_left(X,Z)  :-  just_left(X,Y),  table_left(Y,Z).


% right(X,Y) is the opposite of left(X,Y).
right(Y,X) :- left(X,Y).
