% basic comparisons : < , > , >= , =< , =:= (negate last)

strictlyIncreasing(A,B,C):- A<B,B<C.

nonDecreasing(A,B,C) :- A=<B,B=<C.

% Y is 2, X is Y, \+ X =:= Y.


% try 30/4 , note floating point returned

%other ops available
%div(), also //, integer div., %mod
% note, basically a return (unusual)

% is vs =:= ( left hand of is can be unset for unificaiton)

quotient_remainder(X,Y,Q,R) :- Q is div(X,Y), R is mod(X,Y).

quotient_remainder2(X,Y,Q,R) :- Q is X//Y, R is mod(X,Y).

%square function?
square(B,S) :- S is B^2. 

%sqrt(N). Kind of pointless
square_root(S,SR) :- SR is sqrt(S).

%factorial
factorial(0,1).
factorial(N,NF):-N>0,Nm1 is N-1, factorial(Nm1,Nm1F),NF is N*Nm1F.

%so, what's power of a pow(A,P,A_to_the_P) ?
%yes ^ works in Prolog, but this is recursive...



%define with power(A,0,1) ?
power(_,0,1).
power(A,P,PowA):-P>0,Pm1 is P-1, power(A,Pm1,Pow),PowA is Pow*A.


%so, what's blocks world?

%loc(b1,x,y) screen-coordinate order
loc(b1,0,2).
loc(b2,0,3).
loc(b3,1,0).
loc(b4,1,1).
loc(b5,1,2).
loc(b6,1,3).
loc(b7,2,3).

%generator for blocks?
block(B):- loc(B,_,_).

on(Bt,Bb):-loc(Bt,X,Yt),loc(Bb,X,Yb),Yb =:= Yt+1.

above(Bt,Bb):- loc(Bt,X,Yt),loc(Bb,X,Yb),Yb > Yt.

below(Bb,Bt):- above(Bt,Bb).

left(Bl,Br) :- loc(Bl,Xl,_),loc(Br,Xr,_),Xl<Xr.


%really important - Lists!

%note these examples:
% head_tail([1,2,3,4,5,6], H,T). , H is not list (in general), T is list
% head_tail([1], H,T). , T is empty list
% head_tail([], H,T). ,FAILS, H _must_ match at item and there's no
%     items...
head_tail( [H|T],H,T).

%real predicate is length/2
len([],0).
len([_|T],Len):- len(T,LT), Len is LT+1. 



%sum items in a list
sum([],0).
sum([H|T],Sum):- sum(T,SumT), Sum is SumT+H.


%adjacent equals?

adj_equals([X,X|_]).
adj_equals([X,Y|T]):- \+ X=Y, adj_equals( [Y|T] ).


%class is_sorted (non-decreasing) order, multiple base cases
is_sorted([]).
is_sorted([_]).
is_sorted([X,Y|T]):- X=<Y, is_sorted( [Y|T] ).

%elem (real: member) -- test with M both set and unset
elem(M,[M|_]).
elem(M,[_|T]):-elem(M,T).

%concat (real, append)
%append([1,2,3], [4,5,6],C).
%append(A,B,[1,2,3,4,5,6]).
concat([], B, B).
concat([H|T],B, [H|TB] ) :- concat(T,B,TB).


%elemversion 2
elem2(M,L):- append(_,[M|_],L).

%real predicate is reverse
rev([],[]).
rev([H|T],R) :- rev(T,TR), append(TR,[H],R). 

range(S,F,[]) :- S>F.
range(S,F, [S|Rp1] ) :- S=<F, Sp1 is S+1, range(Sp1,F,Rp1).

% rev2 (library, example of accumulator pattern, also define helper rule
% (always okay)

rev2Acc([],A,A).
rev2Acc([H|T],A,R):- rev2Acc(T,[H|A],R).

rev2(L,R):- rev2Acc(L,[],R).

%subset -- multiple cases
subset([],[]).
subset(SubT,[_|T]) :- subset(SubT,T).
subset([H|SubT],[H|T]) :- subset(SubT,T).

%disjoint
disjoint([],_).
disjoint([H|T],L):- \+ member(H,L), disjoint(T,L).

disjoint2(A,B):- \+ (subset(S,A),subset(S,B), \+ S = [] ).

%disjoint2 using member, NO RECURSION (explicitly)
disjoint3(A,B):- \+ (member(M,A),member(M,B)).

%intersects
intersect(A,B):- member(M,A),member(M,B).

%max rule
max(X,Y,X):-X>=Y.
max(X,Y,Y):-X<Y.

%max of LIST
maxL(L,Max):-member(Max,L), \+ (member(X,L), X>Max).

maxL2([X],X).
maxL2([X,Y|T],Max) :- maxL2([Y|T],MaxT),max(X,MaxT,Max).

%list_evil
list_evil([e,v,i,l|_]).
list_evil([_|T]):-list_evil(T).

%call following line:
% set_prolog_flag(answer_write_options,[max_depth(0)]).


%take



%drop


% % split less efficient with take and drop


% % more efficient version (take, in particular, computes and then
% % discards the drop answer).

% %note use of helper predicate, below
% %split

%split w/ append
split(AB,A,B):-
    length(AB,L),Half is L //2,
    length(A,Half),
    append(A,B,AB).




% %merge_lists


% %what happens if I do <, >= (sort NOT stable - 350)

% merge_sort
%     merge_lists(LSorted,RSorted,Sorted).