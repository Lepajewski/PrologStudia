digits(0,[]).
digits(N,Res) :- Nmod10 is N mod 10, Ndiv10 is N div 10, digits(Ndiv10,Res1),
		 append(Res1,[Nmod10],Res), !.
list_of_digits([],[]).
list_of_digits([H|T],Res) :- digits(H,Digi), list_of_digits(T,Res1),
	                     append([Digi],Res1,Res), !.
max([M],M).
max([H|T],H) :- max(T,M), H > M, !.
max([_|T],M) :- max(T,M).
max_list([],[]).
max_list([H|T],Res) :- max(H,Max), max_list(T,Res1), append([Max],Res1,Res), !.

min([M],M).
min([H|T],H) :- min(T,M), H < M, !.
min([_|T],M) :- min(T,M).
min_list([],[]).
min_list([H|T],Res) :- min(H,Min), min_list(T,Res1), append([Min],Res1,Res), !.

middle([X],X).
middle(L,X) :- append([_|L1],[_],L), middle(L1,X).

rotate([H|T],L) :- append(T,[H],L).

rotate_until(Res,Res,X) :- middle(Res,X).
rotate_until(L,Res,X) :- rotate(L,Res1), rotate_until(Res1,Res,X).

rotate_sublists([],[],[]).
rotate_sublists([H1|T1],[H2|T2],Res) :- rotate_until(H1,Res1,H2),
				   rotate_sublists(T1,T2,Res2),
				   append([Res1],Res2,Res), !.

digits_to_number([X],X,1).
digits_to_number([H|T],X,I) :- digits_to_number(T,X1,I1),
	                           I is I1*10, X is H * I + X1, !.
digi_list_to_nums([],[]).
digi_list_to_nums([H1|T1],Res) :- digits_to_number(H1,Res1,_),
	                          digi_list_to_nums(T1,Res2),
				  append([Res1],Res2,Res), !.
differences([],[],[]).
differences([H1|T1],[H2|T2],Res) :- Diff is abs(H1-H2), differences(T1,T2,Res1),
	                            append([Diff],Res1,Res), !.
idx([X|_],X,0).
idx([_|T],X,I) :- idx(T,X,I1), I is I1 + 1.

solution(X,L) :- list_of_digits(L,LDigits), max_list(LDigits,MaxList),
		 min_list(LDigits,MinList), rotate_sublists(LDigits,MaxList,Max),
		 rotate_sublists(LDigits,MinList,Min),
		 digi_list_to_nums(Max,CombinedMax),
		 digi_list_to_nums(Min,CombinedMin),
		 differences(CombinedMax,CombinedMin,Abss), max(Abss,MaxDiff),
		 idx(Abss,MaxDiff,I), idx(L,X,I).
