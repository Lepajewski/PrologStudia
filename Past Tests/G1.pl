num_to_list(N,[L|[]]) :- N < 10, L is N, !.
num_to_list(N,L) :- M is N//10, num_to_list(M,L1), E is mod(N,10), append(L1,[E],L).

convert_toL([],[]).
convert_toL([H|T1],[X|T2]) :- num_to_list(H,X), convert_toL(T1,T2).

len(0,[]).
len(N,[_|T]) :- len(M,T), N is M+1.

list_to_num([],0).
list_to_num([H|T],M) :- list_to_num(T,M1), len(N,[H|T]), M is M1 + H * 10**(N-1).

split(0,L,[],L).
split(N,[H|T1],[H|T2],X) :- N >= 0, M is N-1, split(M,T1,T2,X).

index_of_el(0,E,[E|_]) :- !.
index_of_el(N,E,[_|T]) :- index_of_el(M,E,T), N is M+1, !.

truncate(E,L1,L1) :-
	len(N,L1), index_of_el(I,E,L1), J is N-I-1, J =:= I, !.
truncate(E,L1,L2) :-
	len(N,L1), index_of_el(I,E,L1), J is N-I-1, J < I, Diff is I-J,
	split(Diff,L1,_,L2), !.
truncate(E,L1,L2) :-
	len(N,L1), index_of_el(I,E,L1), J is N-I-1, J > I, Diff is N-abs(I-J),
	split(Diff,L1,L2,_), !.

maximum([E],E).
maximum([H|T],H) :- maximum(T,E), H > E.
maximum([H|T],E) :- maximum(T,E), H =< E.

minimum([E],E).
minimum([H|T],E) :- minimum(T,E), H > E.
minimum([H|T],H) :- minimum(T,E), H =< E.

truncateMax([],[]) :- !.
truncateMax([H1|T1],[H2|T2]) :-
	maximum(H1,Max), truncate(Max,H1,H2), truncateMax(T1,T2), !.

truncateMin([],[]) :- !.
truncateMin([H1|T1],[H2|T2]) :-
	minimum(H1,Min), truncate(Min,H1,H2), truncateMin(T1,T2), !.

convert_toN([],[]).
convert_toN([H1|T1],[H2|T2]) :- list_to_num(H1,H2), convert_toN(T1,T2).

absV_list([],[],[]).
absV_list([H1|T1],[H2|T2],[H3|T3]) :- H3 is abs(H1-H2), absV_list(T1,T2,T3).

take(0,[H|_],H) :- !.
take(N,[_|T],X) :- M is N-1, take(M,T,X).

solution(L0,Ans) :-
	convert_toL(L0,L1), truncateMax(L1,Lmax), truncateMin(L1,Lmin),
	convert_toN(Lmax,Lmx), convert_toN(Lmin,Lmn), absV_list(Lmx,Lmn,Labs),
	maximum(Labs,Max), index_of_el(I,Max,Labs), take(I,L0,Ans), !.
